# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.destroy_all
Provider.destroy_all
Show.destroy_all
Favorite.destroy_all

alona = User.create(first_name: "Alona", last_name: "Matokhina", password: "12345", email: "alona@alona.com", phone_number: "555-555-5555")
anna = User.create(first_name: "Anna", last_name: "Carey", email: "anna@anna.com", password: "flatiron", phone_number: "777-777-7777")


netflix = Provider.create(name: "Netflix", cost: 13, url: "netflix.com")
hulu = Provider.create(name: "Hulu", cost: 12, url: "hulu.com")
hbo = Provider.create(name: "HBO", cost: 15, url: "hbo.com")
amazon_prime = Provider.create(name: "Amazon Prime", cost: 9, url: "amazon.com/video")

mrs_maisel = Show.create(name: "Marvelous Mrs. Maisel", 
                         description: "An American period comedy-drama web television series, created by Amy Sherman-Palladino, that premiered on March 17, 2017, on Prime Video. The series stars Rachel Brosnahan as Miriam Midge Maisel, a housewife in late 1950s and early 1960s New York City who discovers she has a knack for stand-up comedy and begins actively pursuing a career in it.",
                         image_url: "https://images.immediate.co.uk/production/volatile/sites/3/2018/12/Rachel-Brosnahan-plays-Miriam-Maisel-093c7b3.jpg?quality=90&resize=620,413",
                         provider: amazon_prime)

friends = Show.create(name: "Friends", 
                         description: "Three young men and three young women -- of the BFF kind -- live in the same apartment complex and face life and love in New York. They're not above sticking their noses into one another's business and swapping romantic partners, which always leads to the kind of hilarity average people will never experience -- especially during breakups.",
                         image_url: "https://image.cnbcfm.com/api/v1/image/104781650-NBC_Friends_tv_show.jpg?v=1575564001&w=678&h=381",
                         provider: hulu)

rick_and_morty = Show.create(name: "Rick and Morty", 
                         description: "An animated series that follows the exploits of a super scientist and his not-so-bright grandson.",
                         image_url: "https://cdn.vox-cdn.com/thumbor/TP4QQ7CetOe_npPZHxa7EsKr71c=/0x0:1212x727/1200x800/filters:focal(510x268:702x460)/cdn.vox-cdn.com/uploads/chorus_image/image/59693947/rick_and_morty_s02_still.0.jpg",
                         provider: hulu)  

got = Show.create(name: "Game of Thrones", 
                         description: "Summers span decades. Winters can last a lifetime. And the struggle for the Iron Throne begins. Based on the bestselling book series by George R.R. Martin and created by David Benioff and D.B. Weiss.",
                         image_url: "https://www.hbo.com/content/dam/hbodata/series/game-of-thrones/episodes/1/game-of-thrones-1-1920x1080.jpg/_jcr_content/renditions/cq5dam.web.1200.675.jpeg",
                         provider: hbo)
                         
Favorite.create(user: alona, show: rick_and_morty, months: "Jan 2020, Feb 2020")    
Favorite.create(user: alona, show: friends, months: "Jan 2020, Feb 2020")  
Favorite.create(user: alona, show: mrs_maisel, months: "Mar 2020, Apr 2020")                   
                                    
Favorite.create(user: anna, show: rick_and_morty, months: "Jan 2020, Feb 2020")    
Favorite.create(user: anna, show: friends, months: "Jan 2020, Feb 2020")  
Favorite.create(user: anna, show: got, months: "Mar 2020, Apr 2020")                   
                                    
              


