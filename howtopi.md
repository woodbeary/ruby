# Local LLM Setup with Raspberry Pi

## Initial Setup
1. SSH into Raspberry Pi:
bash
ssh jacoblopez@rubyllm.local


2. Activate the Python virtual environment:
bash
source ~/llama-env/bin/activate


3. Navigate to llama.cpp directory:
bash
cd ~/llama.cpp


4. Start the model server (run this in a screen or tmux session to keep it running):
bash
./llama-cli -m ~/converted-model/llama-3.2-1b.gguf \
--temp 0.7 \
--threads 2 \
--ctx-size 2048 \
--batch-size 128 \
--server --host 0.0.0.0 --port 8080


## Integration with Rails

1. Add these gems to your Gemfile:
ruby:Gemfile
gem 'httparty'
gem 'redis' # Optional, for caching responses


2. Create a service for LLM interactions:
ruby:app/services/llm_service.rb
class LlmService
include HTTParty
base_uri 'http://rubyllm.local:8080' # Your Raspberry Pi's address
def self.classify_priority(incident_description)
response = post('/completion', body: {
prompt: "Given this incident description, classify it as HIGH, MEDIUM, or LOW priority. Respond with just the priority level.\n\nIncident: #{incident_description}",
n_predict: 64,
temperature: 0.7
}.to_json, headers: { 'Content-Type' => 'application/json' })
return 'MEDIUM' unless response.success? # Default fallback
priority = response['content'].strip.upcase
%w[HIGH MEDIUM LOW].include?(priority) ? priority : 'MEDIUM'
end
end


3. Use in your Incident model:
ruby:app/models/incident.rb
class Incident < ApplicationRecord
before_create :set_priority
private
def set_priority
self.priority = LlmService.classify_priority(description)
rescue => e
Rails.logger.error("LLM Priority Classification failed: #{e.message}")
self.priority = 'MEDIUM' # Fallback priority
end
end


## Monitoring and Maintenance

1. Check if model is running:
bash
curl http://rubyllm.local:8080/health


2. Restart model server if needed:
bash
SSH into Pi
ssh jacoblopez@rubyllm.local
Kill existing process if any
pkill llama-cli
Start server again
source ~/llama-env/bin/activate
cd ~/llama.cpp
./llama-cli -m ~/converted-model/llama-3.2-1b.gguf \
--temp 0.7 \
--threads 2 \
--ctx-size 2048 \
--batch-size 128 \
--server --host 0.0.0.0 --port 8080


## Troubleshooting

1. If model server isn't responding:
   - Check if process is running: `ps aux | grep llama-cli`
   - Check logs: `tail -f ~/llama.cpp/server.log`
   - Ensure port 8080 is open: `netstat -tuln | grep 8080`

2. If classification seems incorrect:
   - Review recent classifications: `tail -f log/production.log | grep "LLM Priority"`
   - Adjust prompt in LlmService if needed