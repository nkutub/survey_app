# Surveys App

A Ruby on Rails application for managing surveys and their responses.

## Technical Overview

### Design Decisions

- **Bootstrap Framework**: Utilized Bootstrap for styling and responsive design, providing a clean and professional look while maintaining consistency across the application.

- **Card-Based Layout**: 
  - Chose cards over traditional tables to better handle multi-line questions and complex text formatting
  - Cards provide better visual separation and readability
  - Allows for flexible content expansion without breaking layout

- **Inline Responses**:
  - Responses are displayed within expandable card sections
  - Eliminates need for separate page navigation
  - Provides immediate access to response data
  - Maintains context while viewing responses

- **Pure Rails Approach**:
  - Built without JavaScript dependencies
  - Uses standard Rails form submissions and page refreshes
  - Relies on Bootstrap's built-in collapse functionality
  - Note: Some page flicker occurs during form submissions due to full page refreshes

### Features

- **Pagination**:
  - Limited to 6 surveys per page
  - Prevents excessive scrolling
  - Maintains manageable page length
  - Preserves state across form submissions

- **Mobile Responsive**:
  - Fully responsive design
  - Adapts to different screen sizes
  - Mobile-friendly navigation
  - Readable on all devices

### Code Quality

- **Clean Code**:
  - Follows Ruby style guidelines
  - Implements RuboCop linting
  - Maintains consistent formatting

- **Comprehensive Testing**:
  - Complete test coverage including:
    - System tests for user interactions
    - Controller tests for business logic
    - View tests for proper rendering
    - Model tests for data integrity
  - Extensive view testing for complex UI components
  - Thorough pagination testing
  - Response form submission testing

## Getting Started

1. Set up the database:
```bash
rails db:setup
```

2. Run the test suite:
```bash
rspec
```

3. Start the server:
```bash
rails s
```
