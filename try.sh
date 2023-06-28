
source $1

if [[ -z "$with_default" ]]
then
  echo "Empty"
else
  echo "Not empty"
fi

if [[ -z "$with_$2" ]]
then
  echo "Empty"
  echo "$with_$2"
else
  echo "Not empty"
  varname="with_$2"
  val=$(eval echo "\$$varname")
  echo "$val"
fi
