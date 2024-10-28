# Incident Management System with Local LLM Priority Assessment

## Project Overview
A Rails-based incident management system with local Llama 3.2 1B integration running on Raspberry Pi 5 for incident priority assessment.

### Core Features
1. **User Interface**
   - Modern UI using Hotwire/Turbo and ViewComponents
   - Tailwind CSS for styling (similar to shadcn aesthetic)
   - Responsive dashboard design

2. **Incident Management**
   - Ticket submission form
   - Incident dashboard for managers
   - Real-time updates using Hotwire
   - Priority levels (P1-P4)

3. **LLM Integration**
   - Local Llama 3.2 1B running on Raspberry Pi 5
   - REST API endpoint for priority assessment
   - Priority confirmation modal with LLM suggestion
   - Simple priority levels (P1-P4)

### Technical Stack
- Ruby on Rails 7
- Hotwire (Turbo + Stimulus)
- ViewComponents
- Tailwind CSS
- PostgreSQL
- Google Gemini API
- Authentication (Devise)
- Deployment: Vercel
- Raspberry Pi 5 running Llama 3.2 1B
- Simple Node.js API server
- Local network deployment

### Infrastructure Setup
1. **Raspberry Pi Configuration**
   - SSH setup
   - Llama 3.2 1B installation
   - Node.js API server
   - Port forwarding configuration

2. **Local Deployment**
   - DNS configuration
   - Router port forwarding
   - SSL setup (optional)

### Project Setup Steps
1. Create new Rails project
2. Configure for Vercel deployment
3. Set up PostgreSQL
4. Configure Tailwind CSS
5. Set up ViewComponents
6. Implement authentication
7. Create basic models
8. Implement UI components
9. Add Gemini AI integration
10. Build incident submission flow
11. Create management dashboard
12. Add real-time updates

### Models
1. **User**
   - Role (submitter/manager)
   - Basic info

2. **Incident**
   - Title
   - Description
   - Submitted priority
   - AI-assessed priority
   - Final priority
   - Status
   - Timeline/updates

### API Integration
- Gemini AI endpoint for priority assessment
- Structured prompt for consistent evaluation
- JSON response parsing

### Future Enhancements
- Analytics dashboard
- SLA tracking
- Integration with communication tools
- Automated escalation rules
