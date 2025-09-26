"""Animal Guessing Game, Come Play with us"""

import random;
import from byllm.llm { Model }

glob llm = Model(model_name="gemini/gemini-2.0-flash", verbose=False);
"""AI will help to provide interesting hints if the user guess is not correct"""
def give_animal_hint(guess: str, correct_animal:str) -> str by llm();

glob animals = ["cat","donkey","leopard","dog","fish","bear"];
# the user gets 5 guesses only
walker GuessAnimal {
    has guess: str;
    has attempts: int = 5;
    can start with `root entry;
    can process_guess with animal_node entry;
}
node animal_node {
    has correct_animal: str = random.choice(animals);
}


impl GuessAnimal.start {
    if not [root --> (`?animal_node)] {
        next = root ++> animal_node(random.choice(animals));
    } else {
        next = [root --> (`?animal_node)];
    }
    visit next;
}

impl GuessAnimal.process_guess {
    if [-->] {
        visit [-->];
    } else {
        # The game asks the user for a guess the limit is 5
        while self.attempts > 0 {
        self.guess = input("Welcome to the Animal Game,Please enter your guess: ");
        if self.guess.lower() != here.correct_animal.lower() {
            self.attempts -= 1;
            if self.attempts> 0 {
            print(give_animal_hint(self.guess, here.correct_animal));
            print ("Attempts left are: " + str(self.attempts));
            here ++> animal_node(here.correct_animal);
        } else{
            print("Sorry, You are out of attempts, Better luck next time, The correct animal was: " + here.correct_animal);
            disengage;
        } 
        }else {
            print("Congratulations👏👏👏, That is Correct! You guessed the animal: " + here.correct_animal);
            disengage;
        }
    }
}
}

with entry:__main__ {
    
    root spawn GuessAnimal("start");
   
}