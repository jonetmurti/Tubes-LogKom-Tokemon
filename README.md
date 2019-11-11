# TUBES LOGKOM TOKEMON KELOMPOK 5

############ PEMAIN ###########################

State (waktu sebuah command dapat digunakan) :
1. inBattle	 : Pick, Attcak, SpecialAttack, Run, Drop
2. inGym		 : Heal, Save, Help, Map, Status, Drop, Quit
3. inMap		 : Move, Save, Help, Map, Status, Drop, Quit
5. inMainMenu: Start, Load, Quit

Position (Posisi pemain di map) : Koordinat(x,y)

Inventori : maks 6 Tokemon


############### PETA ########################

1. Symbol (menyatakan apa yg ada di peta)
2. Koordinat(x,y)


############# TOKEMON #######################

Jumlah : legend = 3
				 Normal = 6

// Legendary
1. Name 			 : Rahamon
   Health 		 : 1000
   type				 : Fire
   Normal Att. : 60
   Spc. Att.	 : 70

2. Name 			 : Logkomon
   Health 		 : 1000
   type				 : Water
   Normal Att. : 40   
   Spc. Att.	 : 90
   
3. Name 			 : Hizmon
   Health 		 : 1000
   type				 : Grass
   Normal Att. : 50
   Spc. Att.	 : 80


// Normal
1. Name 		   : Seamon
	 Health 		 : 100
   type				 : Water
   Normal Att. : 20
   Spc. Att.	 : 40

2. Name 		   : Jonemon
	 Health 		 : 190
   type				 : Grass
   Normal Att. : 15
   Spc. Att.	 : 25
  
3. Name 		   :  MamaLemon
	 Health 		 : 180
   type				 : Water
   Normal Att. : 15
   Spc. Att.	 : 30

4. Name 		 	 : Lemon
	 Health 		 : 110
   type				 : Fire
   Normal Att. : 20
   Spc. Att.	 : 35

5. Name 		 	 : Kemon
	 Health 		 : 200
   type				 : Fire
   Normal Att. : 10
   Spc. Att.	 : 30
  
6. Name 		   : Suketmon
	 Health 		 : 125
   type				 : Grass
   Normal Att. : 25
   Spc. Att.	 : 40
   

################## SYNTAX #########################

// Bagian type
type(rahamon, fire).
type(logkomon, water).
type(hizmon, grass).
type(seamon, water).
type(jonemon, grass).
type(mamalemon, water).
type(lemon, fire).
type(kemon, water).
type(suketmon, grass).
   


//status
status :-	write('Your Tokemon')

//start
start :-  write('Gotta catch them all!'),nl,nl,
		  		write('Hello there!'),nl, 
          write('Welcome to the world of Tokemon!'),nl,
          write('My name is Aril!'),nl,
          write('People call me the Tokemon Professor!'),nl, 
          write('This world is inhabited by creatures called Tokemon!') ,nl,
          write('There are hundreds of Tokemon loose in Labtek 5!') ,nl,
          write('You can catch them all to get stronger, but what I am really interested in are the 2 legendary Tokemons, Icanmon dan Sangemon.') ,nl,
          write('If you can defeat or capture all those Tokemons I will not kill you.'),nl,nl,
          write('Available commands:'),nl,
          write('start. 			--start the game!'),nl,
          write('help. 				--show available commands'),nl,
          write('quit. 				--quit the game'),nl,
          write('n. s. e. w.	--mov'),nl,
          write('emap. 				--look at the map'),nl, 
          write('heal. 				--cure Tokemon in inventory if in gym center'),nl,
          write('status. 			--show your status'),nl,
          write('save(Filename). --save your game'),nl,
          write('load(Filename). --load previously saved game'),nl,					
          write('Legends:'),nl,
          write('-X = Pagar'),nl,
          write('-P = Player'),nl,
					write('-G = Gym'),nl,
          !.
          

// Bagian help
help :- state(inGym),
				write('Help :'), nl, nl,
				write('Available Commands : '), nl,
        write('Start --start the game!'), nl, 
        write('Help --show available commands'), nl,
        write('Quit --quit the game'), nl, 
        write('Move : w(North), a(West), s(South), d(East)'), nl,
        write('Map'), nl,
        write('Heal --cure Tokemon in inventory if in gym center'), nl,
        write('Status --show your status'), nl,
        write('Pick(Tokemon) --Capture the Tokemon and store it in your inventory'), nl,
        write('Attack --use only in battle mode'), nl,
        write('SpecialAttack --use only in battle mode'), nl,
        write('Run --When Tokemon appears, you will not fight them'), nl, 
        write('Drop(Tokemon). --Free your Tokemon from inventory'), nl,
        write('save(Filename). --save your game'),nl,
        write('load(Filename). --load previously saved game'),nl,					
        
help :- state(inGym),
				
        
        
        
//Map
map :- 