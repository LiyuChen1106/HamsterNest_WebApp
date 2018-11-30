# release logs
Nov 30,2019 commit id:commit 659121059c5f425ac09598a1b86fbe5ae1f90423
author : Jinyi Chen
1. change the name of "Lend List" to "Lend list" in top banner

Nov 30,2019 commit id:commit 659121059c5f425ac09598a1b86fbe5ae1f90423
author : Jinyi Chen
1. change the view of "item edit"
2. add √ or x infront of item status.
3. change the order of my lists

Nov 24,2019 commit id:commit 0b2ff6a44aa34fde35525040f6c49899f446760f
author : Jinyi Chen
1. admin account
    3 roles: 
        superadmin -> the big boss
        supervisor -> can read all, 
        user       -> normal perople
    
    use db to set superadmin:
        UPDATE users SET superadmin_role = 'true' where id ='1';


Nov 24,2019 commit id:commit 6d5b4b7ef6a6f504e97093260dce6b0804638c81
author : Jinyi Chen
1. rop model, controller, view of history
    rails d model history
    rails d controller histories

    if not work, rails generate migration DropHistory
        drop_table :histories

Nov 21,2019 commit id:6a62e2d3554f546ac4aac5c9aa660b2cb22c4e75
author : Jinyi Chen
1. add link to social pages in the home page
    twitter, facebook, instagram


Nov 21,2019 commit id:f799cd9d8cf3a36f2f8c2666766cf4c91f711e2f
author : Jinyi Chen
1. simple frontend of user, user_profile
    register page, login page, user profile page

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
