# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

		@person1 = Person.create(:login => "froz312", :name => "Caen", :firstname => "Guillaume", :password => "2", :id => "1")	
			@post1 = Post.create(:person_id => @person1.id, :title => "sujet1Froz", :body => "corps du sujet 1 de Froz", :id => "1", :note_post => "")
					
					@comment1 = Comment.create(:author => "gamba", :body => "toto est dans un bateau", :post_id => @post1.id)		
					@comment2 = Comment.create(:author => "unknowX", :body => "et il tombe a l'eau?", :post_id => @post1.id)
			@post2 = Post.create(:person_id => @person1.id, :title => "sujet2Froz", :body => "corps du sujet 2 de Froz", :id => "2", :note_post => "")	
					@comment11 = Comment.create(:author => "007", :body => "Ruby", :post_id => @post2.id)		
					@comment22 = Comment.create(:author => "Adrien", :body => "Capybara", :post_id => @post2.id)	
	
		@person2 = Person.create(:login => "gamba", :name => "Gambarotto", :firstname => "Pierre", :password => "gamba", :id => "2")	
			@post3 = Post.create(:person_id => @person2.id, :title => "sujet1Gamba", :body => "corps du sujet 1 de Gamba", :id => "3", :note_post => "")
					@comment111 = Comment.create(:author => "Guillaume", :body => "REST ou Rspec?", :post_id => @post3.id)		
					@comment222 = Comment.create(:author => "Adrien", :body => "duckpiaf", :post_id => @post3.id)			
			@post4 = Post.create(:person_id => @person2.id, :title => "sujet2Gamba", :body => "corps du sujet 2 de Gamba", :id => "4", :note_post => "")	
					@comment1111 = Comment.create(:author => "Guillaume", :body => "ruby ruck", :post_id => @post4.id)		
					@comment2222 = Comment.create(:author => "Adrien", :body => "?_? Comment 2 ?_?", :post_id => @post4.id)
								
		@person3 = Person.create(:login => "007", :name => "Bond", :firstname => "James", :password => "pw", :id => "3")	
			@post5 = Post.create(:person_id => @person3.id, :title => "sujet1_007", :body => "corps du sujet 1 de 007", :id => "5", :note_post => "")
					@comment11111 = Comment.create(:author => "gamba", :body => "Top 14 Orange", :post_id => @post5.id)		
					@comment22222 = Comment.create(:author => "petitPoisson", :body => "rugby", :post_id => @post5.id)			
			@post6 = Post.create(:person_id => @person3.id, :title => "sujet2_007", :body => "corps du sujet 2 de 007", :id => "6", :note_post => "")	
					@comment111111 = Comment.create(:author => "froz312", :body => "Capybara", :post_id => @post6.id)		
					@comment222222 = Comment.create(:author => "TheCapybara_of_N7", :body => "Rspec gemfile", :post_id => @post6.id)			
					
		# notes post1
		@note1 = Note.create(:post_id => @post1.id, :person_id => @person1.id, :note => "5", :id => "1")
		@note2 = Note.create(:post_id => @post1.id, :person_id => @person2.id, :note => "4", :id => "2")
		@note3 = Note.create(:post_id => @post1.id, :person_id => @person3.id, :note => "3", :id => "3")
		# notes post3
		@note4 = Note.create(:post_id => @post3.id, :person_id => @person1.id, :note => "2", :id => "4")
		@note5 = Note.create(:post_id => @post3.id, :person_id => @person2.id, :note => "3", :id => "5")
		@note6 = Note.create(:post_id => @post3.id, :person_id => @person3.id, :note => "4", :id => "6")
		# notes post5
		@note7 = Note.create(:post_id => @post5.id, :person_id => @person1.id, :note => "1", :id => "7")
		@note8 = Note.create(:post_id => @post5.id, :person_id => @person2.id, :note => "1", :id => "8")
		@note9 = Note.create(:post_id => @post5.id, :person_id => @person3.id, :note => "2", :id => "9")	
		
		
		# Il y a 6 posts, on va en pré-tagger 3 pour le voir lors de la connexion a la page d'acceuil avec n'importe lequel des 3 comptes Person"
		@tag1 = Tag.create(:post_id => @post1.id, :person_id => @person1.id)
		@tag2 = Tag.create(:post_id => @post3.id, :person_id => @person1.id)		
		@tag3 = Tag.create(:post_id => @post5.id, :person_id => @person1.id)		
		
		@tag4 = Tag.create(:post_id => @post2.id, :person_id => @person2.id)
		@tag5 = Tag.create(:post_id => @post4.id, :person_id => @person2.id)		
		@tag6 = Tag.create(:post_id => @post6.id, :person_id => @person2.id)	
		
		@tag7 = Tag.create(:post_id => @post3.id, :person_id => @person3.id)
		@tag8 = Tag.create(:post_id => @post5.id, :person_id => @person3.id)		
		@tag9 = Tag.create(:post_id => @post6.id, :person_id => @person3.id)			
		
		
					
