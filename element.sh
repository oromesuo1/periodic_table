#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --tuples-only -c"
echo -e "Please provide an element as an argument."
read USER_INPUT
MAIN() {
  if [[ $USER_INPUT =~ ^[0-9]+$ ]]
  then
  ATOMIC_NUMBER=$USER_INPUT
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    if [[ -z $NAME ]]
    then
    echo "I could not find that element in the database."
    else
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number = $ATOMIC_NUMBER")
    TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")

    echo "The element with atomic number $ATOMIC_NUMBER is $(echo $NAME | sed 's/ ././') ($(echo $SYMBOL | sed 's/ ././')). It's a $(echo $TYPE | sed 's/ ././'), with a mass of $(echo $ATOMIC_MASS | sed 's/ ././') amu. $(echo $NAME | sed 's/ ././') has a melting point of $(echo $MELTING_POINT | sed 's/ ././') celsius and a boiling point of $(echo $BOILING_POINT | sed 's/ ././') celsius."
    fi
  elif [[ $USER_INPUT =~ ^[a-z|A-Z]{1,2}$ ]]
  then
    SYMBOL_C=$($PSQL "SELECT symbol FROM elements WHERE symbol = INITCAP('$USER_INPUT')")
    if [[ -z $SYMBOL_C ]]
    then
    echo "I could not find that element in the database."
    else
    SYMBOL=$(echo $SYMBOL_C | sed 's/ ././')
      ATOMIC_C=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
      ATOMIC_NUMBER=$(echo $ATOMIC_C | sed 's/ ././')
      # echo "$ATOMIC_NUMBER"
      NAME_C=$($PSQL "SELECT name FROM elements WHERE symbol = '$SYMBOL'")
      NAME=$(echo $NAME_C | sed 's/ ././')
      
      TYPE_C=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE=$(echo $TYPE_C | sed 's/ ././')
      ATOMIC_MASS_C=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      ATOMIC_MASS=$(echo $ATOMIC_MASS_C | sed 's/ ././')
      MELTING_POINT_C=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$(echo $MELTING_POINT_C | sed 's/ ././')
      BOILING_POINT_C=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$(echo $BOILING_POINT_C | sed 's/ ././')
      echo "The element with atomic number $ATOMIC_NUMBER is $(echo $NAME | sed 's/ ././') ($(echo $SYMBOL | sed 's/ ././')). It's a $(echo $TYPE | sed 's/ ././'), with a mass of $(echo $ATOMIC_MASS | sed 's/ ././') amu. $(echo $NAME | sed 's/ ././') has a melting point of $(echo $MELTING_POINT | sed 's/ ././') celsius and a boiling point of $(echo $BOILING_POINT | sed 's/ ././') celsius."
      
    fi
  elif [[ $USER_INPUT =~ ^[a-z|A-H]+$ ]]
  # If an element name is entered
  then
  NAME_C=$($PSQL "SELECT name FROM elements WHERE name = INITCAP('$USER_INPUT')")
    if [[ -z $NAME_C ]]
    then
    echo "I could not find that element in the database."
    else
      NAME=$(echo $NAME_C | sed 's/ ././')
      SYMBOL_C=$($PSQL "SELECT symbol FROM elements WHERE name = '$NAME'")
      SYMBOL=$(echo $SYMBOL_C | sed 's/ ././')
      ATOMIC_C=$($PSQL "SELECT atomic_number FROM elements WHERE symbol = '$SYMBOL'")
      ATOMIC_NUMBER=$(echo $ATOMIC_C | sed 's/ ././') 
      TYPE_C=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) WHERE atomic_number = $ATOMIC_NUMBER")
      TYPE=$(echo $TYPE_C | sed 's/ ././')

      ATOMIC_MASS_C=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      ATOMIC_MASS=$(echo $ATOMIC_MASS_C | sed 's/ ././')
      MELTING_POINT_C=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      MELTING_POINT=$(echo $MELTING_POINT_C | sed 's/ ././')
      BOILING_POINT_C=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number = $ATOMIC_NUMBER")
      BOILING_POINT=$(echo $BOILING_POINT_C | sed 's/ ././')
      # echo "$NAME"
      echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi  
  # echo "The element with atomic number $ATOMIC_NUMBER is $(echo $NAME | sed 's/ ././') ($(echo $SYMBOL | sed 's/ ././')). It's a $(echo $TYPE | sed 's/ ././'), with a mass of $(echo $ATOMIC_MASS | sed 's/ ././') amu. $(echo $NAME | sed 's/ ././') has a melting point of $(echo $MELTING_POINT | sed 's/ ././') celsius and a boiling point of $(echo $BOILING_POINT | sed 's/ ././') celsius."
  else

  echo "I could not find that element in the database."
  fi

}

MAIN $USER_INPUT
