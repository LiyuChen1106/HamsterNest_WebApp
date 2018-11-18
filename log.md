# release logs

Nov 18,2019 commit id:068e1abfa1517c40398a22738e231c0baee2bbe0
author : Jinyi Chen
1. return system is on, 
    borrower click borrow_list -> show_request -> return,
    then lender will see the button "confirm delivery" in lend_list
    after confirm, both sides will display "item returned"


Nov 18,2019 commit id:75eb38e008fff57d534e5e640da75741b8fa5c4d 
author : Liyu Chen
1. Seeding from other files is working. Can directly run rake db:seed


Nov 17,2019 commit id:4dbc5ee84b71ade1bb0b3c707b868052237ff2ad
author : Jinyi Chen
1. fix add profile problem -- force user to add user_profile

Nov 17,2019 commit id:commit 8428a05e095079cb5d6ba66c9cf1e4bb77029968
author : Kailun Li
1. fix item create duplicated problem

Nov 17,2019 commit id: c62bfd2c4e64586cfcfb2d02f4d6f2f476940f0f
author : Jinyi Chen
1. delete one of duplicated create in item.controller
2. fix date_select scope in borrow_request
3. add others to category seeds
