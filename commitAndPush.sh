#!/bin/sh
cd C:\Users\andrzej.wyczalkowski\Documents\sale\Seriale
git add --all
timestamp() {
  date +"at %H:%M:%S on %d/%m/%Y"
}
git commit -am "Regular auto-commit $(timestamp)"
git push origin master
