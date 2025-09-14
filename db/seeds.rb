# db/seeds.rb
puts "Starting seed process..."

# Temporarily disable ActsAsTenant for seeding
if defined?(ActsAsTenant)
  ActsAsTenant.current_tenant = nil
  puts "ActsAsTenant disabled for seeding"
end

# Clear existing data safely
puts "Clearing existing data..."
[UserProgress, TrainingModule, Assessment, Course, User, Company].each do |model|
  if ActiveRecord::Base.connection.table_exists?(model.table_name)
    model.destroy_all
    puts "Cleared #{model.name}"
  end
end

# Create super user FIRST (without company)
puts "Creating super user..."
super_user = User.create!(
  email: 'super@example.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Super',
  last_name: 'Admin',
  role: :super_user,
  company: nil  # Explicitly set to nil for super user
)
puts "Super user created: #{super_user.email}"

# Create sample company
puts "Creating company..."
company = Company.create!(
  name: 'Example Corporation',
  subdomain: 'example',
  contact_email: 'admin@example.com',
  subscription_status: 'active',
  max_users: 50
)
puts "Company created: #{company.name}"

# Create company admin
puts "Creating company admin..."
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Company',
  last_name: 'Admin',
  role: :company_admin,
  company: company
)
puts "Company admin created: #{admin.email}"

# Create staff users
puts "Creating staff users..."
staff_emails = ['staff1@example.com', 'staff2@example.com', 'staff3@example.com']
staff_emails.each do |email|
  staff = User.create!(
    email: email,
    password: 'password',
    password_confirmation: 'password',
    first_name: "Staff#{staff_emails.index(email) + 1}",
    last_name: 'User',
    role: :staff_user,
    company: company
  )
  puts "Staff user created: #{staff.email}"
end

# Create sample course
puts "Creating sample course..."
course = Course.create!(
  title: 'Basic Cybersecurity Awareness',
  description: 'Essential cybersecurity training for all employees covering password security, phishing awareness, and data protection best practices.',
  duration: 60,
  difficulty: :beginner,
  is_active: true,
  created_by: super_user.id,
  company: company
)
puts "Course created: #{course.title}"

# Create training modules
puts "Creating training modules..."
modules_data = [
  { 
    title: 'Introduction to Cybersecurity', 
    content: '<h2>Welcome to Cybersecurity Training</h2><p>This module covers the fundamentals of cybersecurity and why it matters for every employee.</p>', 
    order: 1,
    course: course
  },
  { 
    title: 'Password Security Best Practices', 
    content: '<h2>Creating Strong Passwords</h2><p>Learn how to create and manage secure passwords to protect your accounts.</p>', 
    order: 2,
    course: course
  },
  { 
    title: 'Phishing Awareness', 
    content: '<h2>Recognizing Phishing Attempts</h2><p>Phishing is one of the most common cyber attacks. Learn how to spot and avoid them.</p>', 
    order: 3,
    course: course
  }
]

modules_data.each do |mod_data|
  module_record = TrainingModule.create!(mod_data)
  puts "Training module created: #{module_record.title}"
end

# Create some user progress data for demonstration
puts "Creating user progress data..."
staff_users = User.where(role: :staff_user, company: company)
training_modules = TrainingModule.all

staff_users.each_with_index do |user, index|
  training_modules.each_with_index do |tm, tm_index|
    case index
    when 0 # Complete all modules
      UserProgress.create!(
        user: user,
        training_module: tm,
        status: :completed,
        score: rand(85..100),
        time_spent: rand(300..600),
        completed_at: Time.current - (training_modules.count - tm_index).hours
      )
    when 1 # Complete first 2 modules
      if tm_index < 2
        UserProgress.create!(
          user: user,
          training_module: tm,
          status: :completed,
          score: rand(80..95),
          time_spent: rand(250..550),
          completed_at: Time.current - (2 - tm_index).hours
        )
      elsif tm_index == 2
        UserProgress.create!(
          user: user,
          training_module: tm,
          status: :in_progress,
          time_spent: rand(100..200)
        )
      end
    when 2 # Just start first module
      if tm_index == 0
        UserProgress.create!(
          user: user,
          training_module: tm,
          status: :in_progress,
          time_spent: rand(50..150)
        )
      end
    end
  end
end

# Re-enable ActsAsTenant if needed
if defined?(ActsAsTenant)
  ActsAsTenant.current_tenant = nil
  puts "ActsAsTenant re-enabled"
end

puts "=" * 50
puts "SEED DATA CREATED SUCCESSFULLY!"
puts "=" * 50
puts "LOGIN CREDENTIALS:"
puts "Super User:     super@example.com / password"
puts "Company Admin:  admin@example.com / password" 
puts "Staff User 1:   staff1@example.com / password"
puts "Staff User 2:   staff2@example.com / password"
puts "Staff User 3:   staff3@example.com / password"
puts "=" * 50