desc "Return item notification"
task :email_return_reminder => :environment do
  puts "Sending out email reminders for items to be returned."
#  Appointment.appointments_reminder
  puts "Emails sent!"
end