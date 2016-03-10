# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

dan = User.create!(email: "dan@mail.com", password: "password")
eddie = User.create!(email: "eddie@mail.com", password: "password")
james = User.create!(email: "james@mail.com", password: "password")
meagan = User.create!(email: "meagan@mail.com", password: "password")
tyler = User.create!(email: "tyler@mail.com", password: "password")

sample_1 = Sample.create!(name: "Rabbit Run", description: "Excerpt from the novel", content: "Boys are playing basketball around a telephone pole with a backboard bolted to it. Legs, shouts. The scrape and snap of Keds on loose alley pebbles seems to catapult their voices high into the moist March air blue above the wires. Rabbit Angstrom, coming up the alley in a business suit, stops and watches, though he's twenty-six and six three. So tall, he seems an unlikely rabbit, but the breadth of white face, the pallor of his blue irises, and a nervous flutter under his brief nose as he stabs a cigarette into his mouth partially explain the nickname, which was given to him when he too was a boy. He stands there thinking, the kids keep coming, they keep crowding you up.", user_id: dan.id)

sample_2 = Sample.create!(name: "Glengarry Glen Ross", description: "Excerpt from the play", content: "You certainly don't pal. 'Cause the good news is -- you're fired. The bad news is you've got, all you got, just one week to regain your jobs, starting tonight. Starting with tonights sit. Oh, have I got your attention now? Good. 'Cause we're adding a little something to this months sales contest. As you all know, first prize is a Cadillac Eldorado. Anyone want to see second prize? Second prize's a set of steak knives. Third prize is you're fired. You get the picture? You're laughing now? You got leads. Mitch and Murray paid good money. Get their names to sell them! You can't close the leads you're given, you can't close shit, you ARE shit, hit the bricks pal and beat it 'cause you are going out!", user_id: dan.id)
