bulky = User.create! :username => "bulk_loader", :email => "bulk@getvouched.com", :password => "H3avy L1ft3r!"
bulky.has_role! :admin