#! /bin/bash

PSQL="psql -X --username=freecodecamp --dbname=salon --tuples-only -c"

MAIN_MENU() {

  echo -e "\n1) Cut\n2) Color\n3) Wash"
  read SERVICE_ID_SELECTED


  case $SERVICE_ID_SELECTED in
    1) CUT_OPTION ;;
    2) COLOR_OPTION ;;
    3) WASH_OPTION ;;
    *) MAIN_MENU ;;
  esac
 
}

CUT_OPTION() {
  #echo "you selected the cut option"
  SERVICE=cut
  
   # ask for phone number to check if already a customer
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
# if not a customer ask for name as well
  CUSTOMER_NAME=$($PSQL "SELECT NAME FROM CUSTOMERS WHERE PHONE = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
    # add phone and name into customers database
    INSERT_CUST_RESULT=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    echo -e "\nWhat time would you like to come in?"
    read SERVICE_TIME
    INSERT_APPOINTMENT
  else
# ask for time
    echo -e "\nWhat time would you like to come in?"
    read SERVICE_TIME
    INSERT_APPOINTMENT
  fi
}
COLOR_OPTION() {
  #echo "you selected the color option"
  SERVICE=color
  
   # ask for phone number to check if already a customer
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
# if not a customer ask for name as well
  CUSTOMER_NAME=$($PSQL "SELECT NAME FROM CUSTOMERS WHERE PHONE = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
    # add phone and name into customers database
    INSERT_CUST_RESULT=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    echo -e "\nWhat time would you like to come in?"
    read SERVICE_TIME
    INSERT_APPOINTMENT
  else
# ask for time
    echo -e "\nWhat time would you like to come in?"
    read SERVICE_TIME
    INSERT_APPOINTMENT
  fi
}
WASH_OPTION() {
  #echo "you selected the wash option"
  SERVICE=wash
  
    # ask for phone number to check if already a customer
  echo -e "\nWhat is your phone number?"
  read CUSTOMER_PHONE
# if not a customer ask for name as well
  CUSTOMER_NAME=$($PSQL "SELECT NAME FROM CUSTOMERS WHERE PHONE = '$CUSTOMER_PHONE'")
  if [[ -z $CUSTOMER_NAME ]]
  then
    echo -e "\nWhat is your name?"
    read CUSTOMER_NAME
    # add phone and name into customers database
    INSERT_CUST_RESULT=$($PSQL "insert into customers(phone, name) values('$CUSTOMER_PHONE', '$CUSTOMER_NAME')")
    echo -e "\nWhat time would you like to come in?"
    read SERVICE_TIME
    INSERT_APPOINTMENT
  else
# ask for time
    echo -e "\nWhat time would you like to come in?"
    read SERVICE_TIME
    INSERT_APPOINTMENT
  fi
}

INSERT_APPOINTMENT() {
  #echo "about to insert the appointment"
  #insert into the appointments table order:
  #first: won't insert appointment_id. that will be automatically generated
  #second: select customer_id from customers table. insert that into appts
  #echo "customer name is: $CUSTOMER_NAME"
  CUSTOMER_ID=$($PSQL "select customer_id from customers where name='$CUSTOMER_NAME'")
  
  #echo "customer ID is: $CUSTOMER_ID"
  #third: will insert service_id_selected variable from top into appts
  #fourth: time to be inserted is the service_time variable entered by customer
  INSERT_APPT_RESULT=$($PSQL "insert into appointments(customer_id,service_id,time) values('$CUSTOMER_ID',$SERVICE_ID_SELECTED,'$SERVICE_TIME')")
  echo "I have put you down for a $SERVICE at $SERVICE_TIME, $CUSTOMER_NAME."
}
MAIN_MENU
