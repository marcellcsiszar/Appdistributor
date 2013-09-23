namespace :export do
  desc "Prints all Collection in a seeds.rb way."
  task :seeds => :environment do
    Customer.all.each do |customer|
      puts "Customer.create(#{customer.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    Project.all.each do |project|
      puts "Project.create(#{project.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
    User.all.each do |user|
      puts "User.create(#{user.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end