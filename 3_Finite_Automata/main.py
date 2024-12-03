from FiniteAutomation import *
def main():
    print("Finite Automaton Reader\n")
    #file_path = input("Enter the path to the FA file: ").strip()
    try:
        fa = read_fa_from_file("FA.in")
        print("\nLoaded Finite Automaton:")
        print(fa)

        test_string = input("\nEnter a string to test its validity (or press Enter to exit): ").strip()
        while test_string:
            if fa.is_valid_token(test_string):
                print(f"\"{test_string}\" is a valid lexical token.")
            else:
                print(f"\"{test_string}\" is NOT a valid lexical token.")
            test_string = input("\nEnter another string to test (or press Enter to exit): ").strip()

    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()