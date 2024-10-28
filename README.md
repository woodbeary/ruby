# Incident Manager with Local LLM Priority Assessment

An intelligent incident management system powered by Llama 3.2 1B running locally on Raspberry Pi 5. Built with Ruby on Rails 7, Hotwire, and Tailwind CSS.

## Features

- 🚀 Modern, responsive UI with Hotwire/Turbo and ViewComponents
- 🎨 Sleek design using Tailwind CSS (shadcn-inspired)
- 🤖 Local LLM integration using Llama 3.2 1B
- 🔄 Real-time updates with Hotwire
- 📊 Intelligent priority assessment (P1-P4)
- 🔒 Secure and efficient

## Architecture

### Core Stack
- Ruby on Rails 7
- Hotwire (Turbo + Stimulus)
- ViewComponents
- Tailwind CSS
- PostgreSQL
- Local Llama 3.2 1B on Raspberry Pi 5

### Local LLM Setup
- Raspberry Pi 5 running Llama 3.2 1B
- REST API endpoint for priority assessment
- Low latency, offline-first architecture
- Simple Node.js API server

## Prerequisites

- Ruby 3.2.2
- Node.js 22.9.0
- PostgreSQL
- Raspberry Pi 5 with Llama 3.2 1B installed
- Yarn

## Local Development Setup

1. Clone the repository:
bash
git clone https://github.com/yourusername/incident-manager.git
cd incident-manager


2. Install dependencies:
bash
bundle install
yarn install


3. Setup database:
bash
rails db:create db:migrate


4. Start the development server:
bash
bin/dev


## Raspberry Pi LLM Setup

1. SSH into your Raspberry Pi:
bash
ssh user@rubyllm.local


2. Activate the Python environment:
bash
source ~/llama-env/bin/activate


3. Start the LLM server:
bash
cd ~/llama.cpp
./llama-cli -m ~/converted-model/llama-3.2-1b.gguf \
--temp 0.7 \
--threads 2 \
--ctx-size 2048 \
--batch-size 128 \
--server --host 0.0.0.0 --port 8080


## Deployment

The application is configured for deployment on Render:

1. Create a new web service on Render
2. Link your GitHub repository
3. Add environment variables:
   - `DATABASE_URL`
   - `RAILS_MASTER_KEY`
   - `RAILS_ENV=production`
4. Deploy!

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request


## Acknowledgments

- Llama 3.2 1B by Meta AI
- Ruby on Rails community
- Hotwire team
- Tailwind CSS team

## Project Status

Feel free to report issues and submit pull requests.

---

Woodbeary @imjacoblopez