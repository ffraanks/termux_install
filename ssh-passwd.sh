#!/bin/env bash

clear
printf "Defina uma senha para seu sshd:\n"
passwd
printf "\nSenha definida, habilitando o daemon...\n" && sleep 1
sshd

