# Incident Management System with LLM Priority Assessment

## Project Overview
A Rails-based incident management system inspired by Rootly, featuring automatic incident priority assessment using Gemini AI.

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
   - Gemini AI integration for priority assessment
   - Structured JSON output for incident classification
   - Override capability for managers

### Technical Stack
- Ruby on Rails 7
- Hotwire (Turbo + Stimulus)
- ViewComponents
- Tailwind CSS
- PostgreSQL
- Google Gemini API
- Authentication (Devise)
- Deployment: Vercel

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
