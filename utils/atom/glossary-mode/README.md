# Glossary Mode Package
Provides functionalities for editing Glossaries and maintaining consistency between them.

## TODO
available Glossaries
- [ ] Automatically replace words that matches terms from the glossaries with its term reference
- [ ] Automatically replace term references with words with red strikethrough style for terms that do not longer exist.
- [ ] Show an error/warning when removing a term that has references in the current or other glossaries
- [ ] Sort terms alphabetically
- [ ] Sort terms' attributes alphabetically
- [ ] Create a view to add, update or remove terms in the current glossary

## DONE
- [X] Terms Index table generated automatically on save at the top of the file
- [X] Global Terms references generated automatically on save at the end of the file
- [X] Add `global` option to the index table so when true the table is generated with all the terms from all the 
