 And /the following articles exist/ do |article_table|
   article_table.hashes.each do |article|
     # each returned element will be a hash whose key is the table header.
     # you should arrange to add that movie to the database here.
     Article.create! article
   end
 end
 
 # this extends the current conditions as required for this testing 
 Given /^the blog is set up with two users admin and non-admin$/ do
   Blog.default.update_attributes!({:blog_name => 'The Blag',
                                    :base_url => 'http://localhost:3000'});
   Blog.default.save!
   User.create!({:login => 'admin',
                 :password => 'samepsw',
                 :email => 'admin@edx.com',
                 :profile_id => 1,
                 :name => 'admin',
                 :state => 'active'})
  User.create!({:login => 'non-admin',
                 :password => 'samepsw',
                 :email => 'non-admin@edx.com',
                 :profile_id => 2,
                 :name => 'non-admin',
                 :state => 'active'})
 end
 
 And /^I am logged into the admin panel as "([^"]*)"$/ do |user|
   visit '/accounts/login'
   fill_in 'user_login', :with => "#{user}"
   fill_in 'user_password', :with => 'samepsw'
   click_button 'Login'
   if page.respond_to? :should
     page.should have_content('Login successful')
   else
     assert page.has_content?('Login successful')
   end
 end
 
 # Then /^(?:|I ) should (not) see the section "Merge Articles"
 Then /^(?:|I )should see the section "([^"]*)"$/ do |text|
   if page.respond_to? :should
     page.should have_content(text)
   else
     assert page.has_content?(text)
   end
 end
 
 Then /^(?:|I )should not see the section "([^"]*)"$/ do |text|
   if page.respond_to? :should
     page.should have_no_content(text)
   else
     assert page.has_no_content?(text)
   end
 end
 
 Then /^The "([^"]*)" field should be "([^"]*)"$/ do |field, value|
     field = find_field(field)
     field_value = (field.tag_name == 'textarea') ? field.text : field.value
     if field_value.respond_to? :should
       field_value.should =~ /#{value}/
     else
       assert_match(/#{value}/, field_value)
     end
 end
 
 
