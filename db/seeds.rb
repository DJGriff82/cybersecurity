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

# Create super user FIRST (no company)
puts "Creating super user..."
super_user = User.create!(
  email: 'super@example.com',
  password: 'password',
  password_confirmation: 'password',
  first_name: 'Super',
  last_name: 'Admin',
  role: :super_user,
  company: nil
)
puts "Super user created: #{super_user.email}"

# --- Companies ---
companies_data = [
  {
    name: 'Example Corporation',
    subdomain: 'example',
    contact_email: 'admin@example.com',
    subscription_status: 'active',
    max_users: 50,
    industry: 'Technology'
  },
  {
    name: 'RetailSafe Stores',
    subdomain: 'retailsafe',
    contact_email: 'contact@retailsafe.com',
    subscription_status: 'trial',
    max_users: 25,
    industry: 'Retail'
  }
]

companies = companies_data.map do |cdata|
  company = Company.create!(cdata)
  puts "Company created: #{company.name}"
  company
end

# --- Users (admins + staff) ---
companies.each_with_index do |company, idx|
  # Admin
  admin = User.create!(
    email: "admin#{idx+1}@#{company.subdomain}.com",
    password: 'password',
    password_confirmation: 'password',
    first_name: "#{company.name.split.first}",
    last_name: "Admin",
    role: :company_admin,
    company: company
  )
  puts "Company admin created: #{admin.email}"

  # Staff users
  3.times do |i|
    staff = User.create!(
      email: "staff#{i+1}@#{company.subdomain}.com",
      password: 'password',
      password_confirmation: 'password',
      first_name: "Staff#{i+1}",
      last_name: "User",
      role: :staff_user,
      company: company
    )
    puts "Staff user created: #{staff.email}"
  end
end

# --- Courses per company ---
companies.each do |company|
  course = Course.create!(
    title: "Cybersecurity Basics for #{company.name}",
    description: "Essential training covering passwords, phishing, and data safety for #{company.industry}.",
    duration: 60,
    difficulty: "beginner",
    is_active: true,
    created_by: super_user.id,
    company: company
  )
  puts "Course created for #{company.name}: #{course.title}"

  # Training modules
  modules_data = [
    { title: 'Introduction to Cybersecurity', description: 'Overview of threats and protections.' },
    { title: 'Password Security', description: 'Best practices for strong passwords.' },
    { title: 'Phishing Awareness', description: 'How to detect and avoid phishing.' }
  ]

  modules_data.each_with_index do |mod_data, index|
    module_record = TrainingModule.create!(
      title: mod_data[:title],
      description: mod_data[:description],
      course: course,
      position: index + 1
    )
    puts "Training module created: #{module_record.title}"
  end
end

# --- User Progress Sample ---
puts "Creating sample user progress..."
User.where(role: :staff_user).each_with_index do |user, idx|
  TrainingModule.where(course: user.company.courses).each_with_index do |tm, tm_index|
    case idx % 3
    when 0 # completes everything
      UserProgress.create!(
        user: user,
        training_module: tm,
        status: 2, # completed
        score: rand(80..100),
        time_spent: rand(300..600),
        completed_at: Time.current
      )
    when 1 # partial completion
      if tm_index < 2
        UserProgress.create!(
          user: user,
          training_module: tm,
          status: 2,
          score: rand(70..95),
          time_spent: rand(200..400),
          completed_at: Time.current
        )
      else
        UserProgress.create!(
          user: user,
          training_module: tm,
          status: 1, # in_progress
          time_spent: rand(100..200)
        )
      end
    else # just started
      UserProgress.create!(
        user: user,
        training_module: tm,
        status: 1,
        time_spent: rand(50..100)
      ) if tm_index == 0
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
companies.each_with_index do |company, idx|
  puts "Company Admin #{idx+1}:  admin#{idx+1}@#{company.subdomain}.com / password"
  company.users.staff_user.each_with_index do |staff, sidx|
    puts "Staff User #{idx+1}.#{sidx+1}: #{staff.email} / password"
  end
end
puts "=" * 50
