require 'rake'

desc "Return item notification"
task :email_return_reminder => :environment do
  puts "Sending out email reminders for items to be returned."
  @requests = BorrowRequest.where('(return_status = 1 or return_status = 4) AND (return_date between ? and ?)', Date.today, Date.today + 2.day)
  @return_list = Hash.new
  @return_confirmation_list = Hash.new
  
  @requests.each do |request|
    borrower = request.user_profile
    lender = request.item.user_profile
    
    if request.return_status == 4
      if !@return_list[borrower].nil?
        @return_list[borrower].push(request)
      else
        @return_list[borrower] = [request]
      end
    end
    
    if request.return_status == 1
      if !@return_confirmation_list[lender].nil?
        @return_confirmation_list[lender].push(request)
      else
        @return_confirmation_list[lender] = [request]
      end
    end
  end
  
  puts @return_list
  UserMailer.with(return_list: @return_list).return_reminder_the_day_before_email.deliver
  puts "Emails sent!"
  
#  UserMailer.with(return_list: @return_confirmation_list).return_confirmation_reminder_the_day_before_email.deliver
  
end