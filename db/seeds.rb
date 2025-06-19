# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
puts 'Cleaning database...'
Response.delete_all
Survey.delete_all

puts 'Creating sample surveys and responses...'

# Sample survey questions
SURVEY_QUESTIONS = [
  "Customer Satisfaction Survey:\n\n" \
  "Based on your recent experience with our support team:\n" \
  "• Response time\n" \
  "• Solution provided\n" \
  "• Communication clarity\n\n" \
  'Were you satisfied with the overall service?',

  'Do you enjoy working remotely?',
  'Should we have more team meetings?',
  'Is the documentation helpful?',
  'Would you recommend our product?',
  'Are you satisfied with the current workflow?',
  'Should we organize more social events?',

  # Complex multi-line question 1
  "Project Management Tool Evaluation:\n\n" \
  "After using our new project management system for 3 months:\n\n" \
  "Key Features Used:\n" \
  "• Task Assignment\n" \
  "• Timeline Tracking\n" \
  "• Resource Management\n" \
  "• Team Communication\n\n" \
  'Has this new system improved your productivity?',

  # Complex multi-line question 2
  "Office Environment Assessment:\n\n" \
  "Considering our recent office renovations:\n" \
  "----------------------------------------\n" \
  "Updates Include:\n" \
  "• Standing Desks\n" \
  "• Break-out Spaces\n" \
  "• Quiet Zones\n" \
  "• Improved Lighting\n\n" \
  "Question:\n" \
  'Do these changes enhance your work environment?',

  # Complex multi-line question 3
  "Team Communication Review:\n" \
  "==========================\n\n" \
  "Current Communication Channels:\n" \
  "1. Daily Stand-ups\n" \
  "2. Weekly Team Meetings\n" \
  "3. Monthly Reviews\n" \
  "4. Digital Chat Platforms\n\n" \
  "Context:\n" \
  "We're evaluating our communication practices\n" \
  "to ensure effective team collaboration.\n\n" \
  "Question:\n" \
  'Are these channels sufficient for your needs?'
].freeze

# Create surveys with responses
SURVEY_QUESTIONS.each do |question|
  survey = Survey.create!(question: question)

  # Create random number of responses (5-20) for each survey
  rand(5..20).times do
    survey.responses.create!(
      answer: %i[yes no].sample,
      created_at: rand(1..30).days.ago
    )
  end

  print '.'
end

# Print summary
puts "\nSeeding completed!"
puts 'Created:'
puts "- #{Survey.count} surveys"
puts "- #{Response.count} total responses"
puts "\nYou can now run the application and see the sample data."
