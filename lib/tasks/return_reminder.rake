desc "Return item notification"
task :email_return_reminder => :environment do
  puts "Sending out email reminders for items to be returned."
  BorrowRequest.return_items_reminder
  puts "Emails sent!"
end