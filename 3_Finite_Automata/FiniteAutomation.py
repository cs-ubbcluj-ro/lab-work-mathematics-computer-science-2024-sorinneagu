class FiniteAutomaton:
    def __init__(self, states, alphabet, transitions, start_state, final_states):
        self.states = states
        self.alphabet = alphabet
        self.transitions = transitions
        self.start_state = start_state
        self.final_states = final_states

    def __str__(self):
        return (f"States: {self.states}\n" +
                f"Alphabet: {self.alphabet}\n" +
                f"Transitions: {self.transitions}\n" +
                f"Start State: {self.start_state}\n" +
                f"Final States: {self.final_states}")

    def is_valid_token(self, string):
        current_state = self.start_state
        for char in string:
            if char not in self.alphabet or current_state not in self.transitions or char not in self.transitions[current_state]:
                return False
            current_state = self.transitions[current_state][char]
        return current_state in self.final_states

def read_fa_from_file(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    states = set(lines[0].strip().split(','))
    alphabet = set(lines[1].strip().split(','))
    start_state = lines[2].strip()
    final_states = set(lines[3].strip().split(','))

    transitions = {}
    for line in lines[4:]:
        src, symbol, dest = line.strip().split(',')
        if src not in transitions:
            transitions[src] = {}
        transitions[src][symbol] = dest

    return FiniteAutomaton(states, alphabet, transitions, start_state, final_states)



