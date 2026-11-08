### Prompt for Box Cipher

Build a CTO app for the Crypto Box cipher (slug cryptobox).

Goal: learners should understand how shifting the rows and columns of a
square grid encrypts a text, and why the shifts can be undone.
Source: https://www.ciphermachinesandcryptology.com/en/cryptobox.htm
Test vector (10×10 grid, text written and read row by row; columns A–J
move U/D, rows 0–9 from the top move L/R, one token = one position):
plaintext = "FRANZJAGTIMKOMPLETTVERWAHRLOSTENTAXIQUERDURCHBAYERNZWOELFBOXKAEMPFERJAGENVIKTORQUERUEBERDENXXXXXXXXX"
key = "3R GU 0L 0L AD BU 0L 4R HU 4L"
ciphertext = "KZJEGTITRNAROMPLLOTVMEWAHRIQSTEUNTAXAFUERZRCHBBYERDAWOELEROXNEEMPFTOJAKENVIKERRQGXRUEBXXDEUNXXXXAFXX"
Must have: encryption and decryption; random key generation of variable
length (default 10 moves); an interactive visualization of the grid where
the user can shift rows and columns with buttons and step through the key.
Done when: algorithm tests pass (including the test vector), readmes in
English and German, registry entry and icon exist, and the app works at
375 px and in dark mode.

Before planning, ask me about anything that is unclear.

# Prompt for Route Cipher

Build a CTO app for the Route Cipher (slug routecipher).

Goal: learners should understand how the Union Army in the American Civil
War hid messages by writing words into a grid and reading them out along a
route, and why code words and null words made it hard to break.
Source: "Impractical Python Projects" by Lee Vaughan, 2018, 424 pp.,
chapter 4, Project #8.
Test vector (words written row by row; the key lists the columns in reading
order, a negative number means bottom to top, key length = number of
columns; REST IS JUST FILLER are null words added by hand):
plaintext = "VILLAGE ROANOKE HEADING TO GODWIN WITH SNOW GONE YOU ARE FREE TO TRANSPORT YOUR SUPPLIES SOUTH REST IS JUST FILLER"
key = "-1 2 -3 4"
ciphertext = "REST TRANSPORT YOU GODWIN VILLAGE ROANOKE WITH ARE YOUR IS JUST SUPPLIES FREE SNOW HEADING TO GONE TO SOUTH FILLER"
Must have: encryption and decryption of text with only A–Z, a–z and blanks;
only full grids are processed, otherwise a warning shows how many words are
missing (nothing is filled in automatically); random key generation that
keeps the number of columns; an editable code-word table (case-insensitive);
a visualization of the grid that shows the route
Done when: algorithm tests pass (including the test vector), readmes in
English and German, registry entry and icon exist, and the app works at
375 px and in dark mode.

Before planning, ask me about anything that is unclear.
