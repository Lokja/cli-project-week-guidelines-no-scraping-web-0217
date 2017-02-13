
# MTG API Search

## Contents

1. Introduction
2. Instructions

## Introduction

This is a simple yet somewhat robust search application for Magic: The Gathering cards.
As with the Star Wars Lab, for the sake of the spirit of the exercise, we ping each page of the API and then perform our own search instead of simply using the API's built in search functions or saving the data locally.


## Instructions

Simply run the app, and the instructions for the program will be presented to you. A brief rundown though:
* The user decide to 'start', get 'help', or 'exit'
* 'start' will run the program, 'exit' will quit, and 'help' will display a list of options and commands.
* Once the user starts, they must enter one or more color identity(s) they wish to search for, then a converted mana cost, and finally one or more types. At any time the user can still pull up help or quit.
* Then, they user will simply wait for the API calls to be made and then be presented with a list of names of cards that match the search parameters.
* Finally, the user is greeted with original prompt to either search again or quit.
