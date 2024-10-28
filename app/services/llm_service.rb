class LlmService
  def self.classify_priority(description)
    begin
      Rails.logger.info "Starting priority classification for: #{description}"
      prompt = <<~PROMPT
        You are an IT incident priority classifier. Respond with P1, P2, P3, or P4 only.
        Rules:
        - P1: Critical issues affecting all users or core business functions
        - P2: High priority issues affecting many users or important functions
        - P3: Medium priority issues affecting some users or non-critical functions
        - P4: Low priority issues affecting few users or cosmetic issues

        Incident description: #{description}

        Priority (start with P): P
      PROMPT

      response = HTTP.post("http://104.28.85.145:8080/completion", json: {
        prompt: prompt,
        n_predict: 32,
        temperature: 0.3,
        stop: ["\n", " ", ",", "."]
      })
      
      if response.status.success?
        data = JSON.parse(response.body.to_s)
        Rails.logger.info "LLM Response: #{data.inspect}"
        priority = "P#{data['content']}"
        Rails.logger.info "Parsed priority: #{priority}"
        return priority if ['P1', 'P2', 'P3', 'P4'].include?(priority)
        return 'P4' # Fallback if response is invalid
      else
        Rails.logger.error "LLM API error: #{response.status} - #{response.body}"
        return "P4" # Default to lowest priority if API fails
      end
    rescue => e
      Rails.logger.error "LLM API error: #{e.message}\n#{e.backtrace.join("\n")}"
      return "P4" # Default to lowest priority if API fails
    end
  end
end 