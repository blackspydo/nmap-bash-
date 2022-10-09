

#!/bin/bash
#color
END="\e[1m"
Red="\e[31m"
GREEN="\e[32m"
BOLDGREEN="\e[1;${GREEN}"
YELLOW="\033[0;33m"
Cyan="\e[0;36m"
white="\e[0;37m"
#check you are root or not
if [ $EUID -ne 0 ]
  then echo -e "${Red}Please run as a root${END}"
  exit
fi

mkdir alltools
cd alltools
echo "Check the requirements"
sleep 3s
requirements(){
go_v=$(go version) &>/dev/nulls
if ! command -v go &> /dev/null
then
    echo "go is not installed"
    echo "installing go now "
    # echo "Check this "
    # echo "https://github.com/Micro0x00/Arsenal/blob/main/README.md#go-lang-installation"
    sudo apt-get remove -y golang-go &>/dev/nulls
    sudo rm -rf /usr/local/go &>/dev/nulls
    wget https://go.dev/dl/go1.19.1.linux-amd64.tar.gz &>/dev/nulls
    sudo tar -xvf go1.19.1.linux-amd64.tar.gz &>/dev/nulls
    sudo mv go /usr/local
    #  sudo echo "export GOPATH=$HOME/go" >> /etc/profile
    #  sudo echo "export PATH=$PATH:/usr/local/go/bin" >> /etc/profile
    #  sudo echo "export PATH=$PATH:$GOPATH/bin" >> /etc/profile
    awk 'BEGIN { print "export GOPATH=$HOME/go" >> "/etc/profile" }'
    awk 'BEGIN { print "export PATH=$PATH:/usr/local/go/bin" >> "/etc/profile" }'
    awk 'BEGIN { print " export PATH=$PATH:$GOPATH/bin" >> "/etc/profile" }'
    source /etc/profile #to update you shell dont worry
else
echo -e "${Cyan}Go is already installed and your version is:${go_v:13}${END}"
fi

#version
git_v=$(git --version) &> /dev/null
py_v=$(python3 --version) &> /dev/null
ruby_v=$(ruby -v) &>/dev/nulls
rust_v=$(rustc --version)

# Check For The requirements
if ! command -v git &> /dev/null
then
    echo "Git is not installed, we will install it for you now"
    echo "Installing Git"
    apt-get install git -y &> /dev/null
    if command -v git &> /dev/null
    then
        echo "git has been installed"
    fi
else
    echo -e "${BOLDGREEN}Git is already installed and your version is:${git_v:11}${END}"
fi
if ! command -v ruby -v &> /dev/null
then
    echo "ruby is not installed we will installed it for you now "
    echo "Installing ruby"
    apt-get install ruby-full -y
    if command -v ruby -v &> /dev/null
    then
        echo "Ruby has been installed"
    fi
else
    echo -e "${Red}Ruby is already installed and your version is: ${ruby_v:5:5}${END}"
fi
if ! command -v  rustc --version  &> /dev/null
then
    echo "rust is not installed we will installed it for you now "
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    if command -v rustc --versiony &> /dev/null
    then
        echo "Rust has been installed"
    fi
else
    echo -e "${white}Rust is already install and your version is: ${rust_v:5:8}${END}"
fi
if ! command -v python3 &> /dev/null
then
    echo "python is not installed we will installed it for you now "
    apt-get install python3 -y &> /dev/null
    apt install python3-pip -y &> /dev/null
    if command -v python3 &> /dev/null
    then
        echo "DONE"
    fi
else
    echo -e "${YELLOW}Python is already install and your version is :${py_v:6}${END}"
fi


}
#Tools Time
Tools(){
    # echo "Check if httpx installed or not"
    if ! command -v httpx -h &> /dev/null
then
read -p "Do you want install httpx (Y/n) ? " choice
case $choice in

  no | NO | n | No | N)
    echo  "o"
    ;;

  yes | YES | Y | Yes | y)
        echo "installing httpx now"
        go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest &> /dev/null
        sudo cp $HOME/go/bin/httpx /usr/local/bin
        if command -v httpx &> /dev/null
        then
        echo "httpx has been installed "
        fi
                ;;
esac

    else
        echo "httpx is already installed"
fi
    # echo "Check if httprobe installed or not"
if ! command -v  &> /dev/null
    then
    read -p "Do You want install httprobe " choice
    case $choice in
    no | No | NO | n)
    echo -e "skip "
    ;;
    yes| YES | Yes | y | Y )
    echo "Instaliing httprobe now "
    go install github.com/tomnomnom/httprobe@latest
    sudo cp $HOME/go/bin/httprobe /usr/local/bin
    echo "httprobe has been installed"

    ;;
    esac
    else
    echo "httprobe is already installed"

    fi
        # echo "Check if amass installed or not"
  if ! command -v amass &> /dev/null
    then
    read -p "Do You want install ammas (Y/n) ?" choice
    case $choice in
    no | No | NO | n)
    echo -e "skip"
    ;;
    yes| YES | Yes | y | Y)
    go install -v github.com/OWASP/Amass/v3/...@master &> /dev/null
        echo "Instaliing amass now "
    sudo cp $HOME/go/bin/amass /usr/local/bin
      echo "amass has been installed"
    ;;
    esac
    else
   echo "amass is already installed"

    fi
 if ! command -v gobuster &> /dev/null
    then
 read -p "Do You want install gobuster (yes/no) ?" choice
    case $choice in
    no | No | NO | n)
    echo -e "skip"
    ;;
    yes| YES | Yes | y )
    echo "Instaliing gobuster now "
    go install github.com/OJ/gobuster/v3@latest

    sudo cp $HOME/go/bin/gobuster /usr/local/bin
    echo "GoBuster has been installed"
    ;;
    esac
    else
    echo "Gobuster is already installed"

 fi
 if ! command -v nuclei &> /dev/null
 then
 read -p "Do You want install nuclei (Y/n) ? " choice
    case $choice in
    no | No | NO | n)
    echo -e  "skip"
    ;;
    YES | Yes | y | yes | Y)
    echo "Instaliing nuclei now "
    go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
    sudo cp $HOME/go/bin/nuclei /usr/local/bin
     echo "nuclei installiotion is done"

    ;;
    esac
    else
       echo "nuclei is already installed"


   fi

 if ! command -v subfinder &> /dev/null
then
    read -p "Do You want install subfinder (Y/n) ?" choice
    case $choice in
        no | No | NO | n )
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y )
        echo -e "skip "
        echo "Instaliing subfinder now "
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
        sudo cp $HOME/go/bin/subfinder /usr/local/bin
        ;;
        esac

    else
    echo "subfinder is already installed"
fi
    if ! command -v assetfinder &> /dev/null
then
    read -p "Do You want install assetfinder (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing assetfinder now "
        sudo go install github.com/tomnomnom/assetfinder@latest
        sudo cp $HOME/go/bin/assetfinder /usr/local/bin
        echo "assetfinder has been installed "

        ;;
        esac

    else
        echo " assetfinder is installed"


fi
    if ! command -v ffuf &> /dev/null
then
    read -p "Do You want install ffuf (Y/n) ? " choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y )
        echo "Instaliing ffuf now "
        go install github.com/ffuf/ffuf@latest
        cp $HOME/go/bin/ffuf /usr/local/bin
        echo "ffuf has been installed "

        ;;
        esac

    else
        echo "ffuf is already installed"


fi
if ! command -v gf &> /dev/null
then
    read -p "Do You want install gf (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y )
        echo "Instaliing gf now "
        go install github.com/tomnomnom/gf@latest
        cp $HOME/go/bin/gf /usr/local/bin
        echo "gf has been installed"
        ;;
        esac

    else
        echo "gf is already installed"


fi
 if ! command -v meg &> /dev/null
then
    read -p "Do You want install meg (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing meg now "
        go install github.com/tomnomnom/meg@latest
        cp $HOME/go/bin/meg /usr/local/bin
        echo "meg has been installed"
        ;;
        esac

    else
        echo "meg is already installed"


fi
if ! command -v waybackurls &> /dev/null
then
    read -p "Do You want install waybackurls (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing waybackurls now "
        go install github.com/tomnomnom/waybackurls@latest
        cp $HOME/go/bin/waybackurls /usr/local/bin
        ;;
        esac

    else
        echo "waybackurls is already installed"


fi

    if ! command -v subzy &> /dev/null
    then
        read -p "Do You want install subzy (Y/n) ?" choice
        case $choice in
            no | No | NO | n)
            echo -e "skip"
            ;;
            yes| YES | Yes | y| Y )
            go get -u -v github.com/lukasikic/subzy &> /dev/null
            echo "Instaliing subzy now "

            go install -v github.com/lukasikic/subzy@latest

            sudo cp $HOME/go/bin/subzy /usr/local/bin
            echo "subzy has been installed"
            ;;
            esac

    else
        echo "subzy already installed"


    fi
if ! command -v dnsx &> /dev/null
then
    read -p "Do You want install dnsx (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y |Y )
        echo "Instaliing dnsx now "
        go install -v github.com/projectdiscovery/dnsx/cmd/dnsx@latest
        sudo cp $HOME/go/bin/dnsx /usr/local/bin
        echo "dnsx has been installed"
        ;;
        esac

    else
        echo "dnsx is already installed"

fi
if ! command -v gospider &> /dev/null
then
    read -p "Do You want install gospider (Y/n) ? " choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing gospider now "
        go install github.com/jaeles-project/gospider@latest
        sudo cp $HOME/go/bin/gospider /usr/local/bin
         echo "gospider has been installed"
        ;;
        esac

    else
        echo " gospider is  already installed"
    fi
     if ! command -v wpscan &> /dev/null
then
    read -p "Do You want install wpscan (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing wpscan now "
        gem install wpscan
        if command -v wpscan -h
        then
         echo "wpscan has been installed"
        fi
        ;;
        esac

    else
        echo "wpscan already installed"


fi
    if ! command -v CRLFuzz &> /dev/null
then
    read -p "Do You want install CRLFuzz (Y/n) " choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y )
        echo "Instaliing CRLFuzz now "
        go install github.com/dwisiswant0/crlfuzz/cmd/crlfuzz@latest
        sudo cp $HOME/go/bin/crlfuzz /usr/local/bin
        ;;
        esac
 #CRLFuzz
    else
        echo " CRLFuzz has been installed"
    fi

    read -p "Do You want install dontgo403 (Y/n)" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing dontgo403 now "
        git clone https://github.com/devploit/dontgo403 &> /dev/null
        cd dontgo403
         go get
         go build
         echo "Try ./dontgo403 -h to run"
         cd -
        ;;
        esac

     if ! command -v uncover &> /dev/null
then
    read -p "Do You want install uncover (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y |Y )
        echo "Instaliing uncover now "
        go install -v github.com/projectdiscovery/uncover/cmd/uncover@latest &> /dev/null
        sudo cp $HOME/go/bin/uncover /usr/local/bin
        ;;
        esac
 #uncover
    else
        echo "uncover is already  installed"
    fi
if ! command -v dalfox &> /dev/null
then
    read -p "Do You want install Dalfox (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y )
        echo "Instaliing Dalfox now "
        go install github.com/hahwul/dalfox/v2@latest
        cp $HOME/go/bin/dalfox /usr/local/bin
        echo "dalfox has been installed"
        ;;
        esac

    else
        echo "dalfox is already installed"


fi

if ! command -v GoLinkFinder &> /dev/null
then
    read -p "Do You want install GoLinkFinder (Y/n) ?" choice
    case $choice in
        no | No | NO | n)
        echo -e "skip"
        ;;
        yes| YES | Yes | y | Y)
        echo "Instaliing GoLinkFinder now "
        go install github.com/0xsha/GoLinkFinder@latest
        cp $HOME/go/bin/GoLinkFinder /usr/local/bin
        echo "GoLinkFinder has been installed"
        ;;
        esac

    else
        echo "GoLinkFinder is already installed"


fi
 read -p "Do You want install knockpy (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y )

     echo -e "installing knockpy"
     git clone https://github.com/guelfoweb/knock.git  &> /dev/null
     cd knock
     pip3 install -r requirements.txt
     cd -
     ;;
     esac
      read -p "Do You want install XSStrike (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y )
     echo -e "installing XSStrike"
     git clone https://github.com/s0md3v/XSStrike &> /dev/null
     cd XSStrike
     pip3 install -r requirements.txt
     echo -e "Done"
     cd - &> /dev/null
     ;;
     esac
        read -p "Do You want install Logsensor (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
     echo -e "installing Logsensor"
     git clone https://github.com/Mr-Robert0/Logsensor.git &> /dev/null
    cd Logsensor
    chmod +x logsensor.py
    chmod +x install.sh
    pip install -r requirements.txt
    ./install.sh &> /dev/null
    echo "Logsensor has been installed"
    cd - &> /dev/null
     ;;
     esac
 read -p "Do You want install Altdns (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
     echo -e "installing Altdns"
      git clone https://github.com/infosec-au/altdns.git &> /dev/null
        cd altdns
        pip3 install -r requirements.txt
        echo "Altdns has been installed"
        echo "to run try python3 altdns --help"
        cd - &> /dev/null

     ;;
     esac
     read -p "Do You want install xnLinkFinder (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git  &> /dev/null
    cd xnLinkFinder
    python3 setup.py install
        echo "xnLinkFinder has been installed"
        cd -
     ;;# nsb2 of j us45 ry 3ybd #encoded
    esac
      read -p "Do You want install ParamSpider (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y )
    git clone https://github.com/devanshbatham/ParamSpider &> /dev/null
    cd ParamSpider
    pip3 install -r requirements.txt
        echo "ParamSpider has been installed"
        echo "To use try python3 paramspider.py --domain target.com"
        cd - &> /dev/null
     ;;
     esac
     read -p "Do You want install NoSQLMap (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y |Y )
    git clone https://github.com/codingo/NoSQLMap.git &> /dev/null
    cd NoSQLMap
    python3 setup.py install /dev/null

        echo "NoSQLMap has been installed"
        cd - &> /dev/null
     ;;
     esac
     read -p "Do You want install EyeWitness (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/FortyNorthSecurity/EyeWitness.git     &> /dev/null
     ./EyeWitness/Python/setup/setup.sh

        echo "EyeWitness has been installed"
        cd - &> /dev/null
     ;;
     esac

  read -p "Do You want install chameleon (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    curl -sL https://raw.githubusercontent.com/iustin24/chameleon/master/install.sh | bash

        echo "Chameleon has been installed"
        cd -
     ;;
     esac

 read -p "Do You want install GraphQLmap (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/swisskyrepo/GraphQLmap
    cd GraphQLmap/
    python3 setup.py install
        echo "GraphQLmap has been installed"
        cd -
     ;;
     esac

 read -p "Do You want install WhatWeb (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
     git clone https://github.com/urbanadventurer/WhatWeb.git
    cd WhatWeb/
    gem install bundler
    bundle update
    bundle install
    echo "WhatWeb has been installed"
    cd -
     ;;
     esac

read -p "Do You want install http request smuggling (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/anshumanpattnaik/http-request-smuggling.git
    cd http-request-smuggling
    pip3 install -r requirements.txt
    echo "http request smuggling has been installed"
    cd -
     ;;
     esac


read -p "Do You want install commix (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/commixproject/commix.git commix
    cd commix
    echo "commix has been installed"
    cd -
     ;;
     esac

read -p "Do You want install JWT_TOOL (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/ticarpi/jwt_tool
    cd jwt_tool
    python3 -m pip install termcolor cprint pycryptodomex requests
    chmod +x jwt_tool.py
    echo "JWT_TOOL has been installed"
    cd -
     ;;
     esac


read -p "Do You want install Arjun (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/s0md3v/Arjun
    cd Arjun
    python3 setup.py install    
    echo "Arjun has been installed"
    cd -
     ;;
     esac
read -p "Do You want install Gitleaks (Y/n) " choice
     case $choice in
     no | No | NO | n)
     echo -e "skip"
     ;;
     yes| YES | Yes | y | Y)
    git clone https://github.com/zricethezav/gitleaks.git
    cd gitleaks
    make build
    mv gitleaks /usr/local/bin
    cd -
     ;;
     esac
}


requirements
Tools
