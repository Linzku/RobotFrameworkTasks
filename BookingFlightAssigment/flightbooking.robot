#Made by LL
*** Settings ***
Library    SeleniumLibrary
Library    String
*** Variables ***

${URL}    http://blazedemo.com/
${BROWSER}    Chrome
${city1}    Boston
${city2}    Cairo

*** Test Cases ***

mene blazedemo sivulle tarkista tietoja 

#Avaa chrome ja pidä se auki
    Open Browser    ${URL}     ${BROWSER}    options=add_experimental_option("detach", True)

#Maksimoi ikkuna
    Maximize Browser Window
    Sleep    2

#Sivulla tulisi lukea ""Welcome to the Simple Travel Agency!"
    Page Should Contain    Welcome to the Simple Travel Agency!
    Sleep    2

*** Test Cases ***
Valitse lähtö ja saapumis kaupunki

#Valitaan lähtö kaupunki      
    Click Element    name:fromPort
    Select From List By Label    name:fromPort    ${city1}
    Sleep    2

#Valitaan saapumis kaupunki 
    Click Element    name:toPort
    Select From List By Label    name:toPort    ${city2}
    Sleep    2

#Tarkistetaan, että sivun nappi toimii ja painetaan sen jälkeen sitä
    Element Should Be Enabled    xpath:/html/body/div[3]/form/div/input
    Click Button    xpath:/html/body/div[3]/form/div/input


*** Test Cases ***
Valitaan lento

#Katsotaan, että seuraavalla sivulla lukee "Flights from Boston to Cairo:"" ja muuttujilla kaupungin nimet
    Page Should Contain    Flights from ${city1} to ${city2}:
    Sleep    2

#Tarkistetaan, että sivu sisältää edes yhden lentovaihtoehdon
    Page should contain Element    xpath:/html/body/div[2]/table/tbody/tr[*]
   
    Log    MUhahahhaaa

#Otetaan muuttujaan halutun lennon tietoja

#Alkuun lennon hinta
    ${hinta_lennon}=    Get Text    xpath:/html/body/div[2]/table/tbody/tr[2]/td[6]
    ${hinta}=    Set Variable    ${hinta_lennon}
    Log    ${hinta} 
    ${hinta}=    Get Substring    ${hinta}    1
    Log    ${hinta}    
    Set Global Variable    ${hinta}

    #Vois myös tällee niiku alla nii tehä nii ei tuu ongelmaa sit siit $merkistä
    # Set Global Variable    \${hinta}
    Log To Console    Lennon hinta ${hinta}
    Sleep    1

#Sitten lennon numero
    ${lennonnumero}=    Get Text    xpath:/html/body/div[2]/table/tbody/tr[2]/td[2]
    ${numero}=    Set Variable    ${lennonnumero}
    Log To Console    Lennon numero ${numero}
    Set Global Variable    ${numero}
    Sleep    1

#Sitten lentoyhtiö
    ${lentoyhtiönnimi}=    Get Text    xpath:/html/body/div[2]/table/tbody/tr[2]/td[3]
    ${yhtiö}=    Set Variable    ${lentoyhtiönnimi}
    Set Global Variable    ${yhtiö}
    Log To Console    Lentoyhtiö ${yhtiö}
    Sleep    1

#Sitten Valitaan se lento ja clikataan seuraavalle sivulle
    Click Button    xpath:/html/body/div[2]/table/tbody/tr[2]/td[1]/input

*** Test Cases ***
Valitun lennon tutkiminen

#Koska sivu on se joku määrätty niin testataan onko aiempi hinta sama  kuin uusi hinta
    ${Uuushinta}=    Get Text    xpath:/html/body/div[2]/p[3]
    ${Uuushinta}=    Get Substring    ${Uuushinta}    7
    Log To Console    ${Uuushinta}
    Run Keyword And Continue On Failure    Should Be Equal   ${hinta}    ${Uuushinta}    

#Koska sivu on se joku määrätty niin testataan onko aiempi numero sama  kuin uusi numero
    ${Uuusnumero}=    Get Text    xpath:/html/body/div[2]/p[2]
    ${Uuusnumero}=    Get Substring    ${Uuusnumero}    15
    Log To Console    ${Uuusnumero}
    Run Keyword And Continue On Failure    Should Be Equal   ${numero}    ${Uuusnumero}

#Koska sivu on se joku määrätty niin testataan onko aiempi lentoyhtiö sama  kuin uusi lentoyhtiö
    ${Uuusyritys}=    Get Text    xpath:/html/body/div[2]/p[1]
    ${Uuusyritys}=    Get Substring    ${Uuusyritys}    9
    Log To Console    ${Uuusyritys}
    Run Keyword And Continue On Failure    Should Be Equal   ${yhtiö}    ${Uuusyritys}


#Otetaan talteen vielä kokonaishinta
    ${hintaKokonaishinta}=    Get Text    xpath:/html/body/div[2]/p[5]/em
    ${hintakokonais}=    Set Variable    ${hintaKokonaishinta}
    Log    ${hintakokonais}    
    Set Global Variable    ${hintakokonais}
    Log To Console    Lennon kokonaishinta ${hintakokonais}

*** Test Cases ***
Lennon henkilön tietojen täyttö
    
#Täytä matkustajan tiedot kaavakkeelle (aseta kortin kuukausi ja vuosi globaaleiksi muuttujiksi)
    
    #nimi
    Click Element    name:inputName
    Input Text    name:inputName     John Smith
    Sleep    1

    #Osoite
    Click Element    name:address
    Input Text    name:address    Street street 2
    Sleep    1

    #Kaupunki
    Click Element    name:city
    Input Text    name:city    Rockport         
    Sleep    1

    #Osavaltio
    Click Element    name:state
    Input Text    name:state     Massachusetts
    Sleep    1

    #Zipcode
    Click Element    name:zipCode
    Input Text    name:zipCode     01966
    Sleep    1

    #Kortin tyyppi, joka piti olla Diner's Club
    Click Element    name:cardType
    Select From List By Label    name:cardType    Diner's Club
    Sleep    1

    #Kortin numero
    Click Element    name:creditCardNumber
    Input Text    name:creditCardNumber     1234 5678 99
    Sleep    1

    #Kortin kuukausi
    Click Element    name:creditCardMonth
    Input Text    name:creditCardMonth    12
    Sleep    1

    #Kortin Name on Card
    Click Element    name:creditCardYear
    Input Text    name:creditCardYear     2024
    Sleep    1

    #Kortin haltijan nimi
    Click Element    name:nameOnCard
    Input Text    name:nameOnCard     John Smith
    Sleep    1
    
    #tee globaalit muuttujat kortin kk ja vuodesta
    Set Global Variable    ${Kortinkk}    12
    Set Global Variable    ${Kortinvuosi}    2024
    
    #Valitse checkboxi ja testaa että se valittu ennen kuin etenet huviks
    Select Checkbox    xpath:/html/body/div[2]/form/div[11]/div/label/input
    Checkbox Should Be Selected    xpath:/html/body/div[2]/form/div[11]/div/label/input
    Sleep    1

    #mene eteenpäin klikkaamalla
    Click Button    xpath:/html/body/div[2]/form/div[11]/div/input

*** Test Cases ***
Tarkista auekavan sivun tiedot
    
    #Sivulla tulisi lukea "Thank you for your purchase today!"
    Page Should Contain    Thank you for your purchase today!
    Sleep    1

    #Tarkistetaan, onko expiroitumisaika kuukausi ja vuosi on oikein seuraavalla sivulla
    ${Uuskkvuos}=    Get Text    xpath:/html/body/div[2]/div/table/tbody/tr[5]/td[2]
    Log To Console    ${Uuskkvuos}
    Run Keyword And Continue On Failure    Should Be Equal   ${Kortinkk} /${Kortinvuosi}    ${Uuskkvuos}
    Sleep    1
    
    ##HUOM SEURAAVAT 2 VAIHTOEHTOINEN TAPA TARKISTAA KORTIN EXP KK JA VUOS erikseen omaks iloks/oppimiseks
    #Tarkistetaan, onko expiroitumisaika kuukausi on oikein seuraavalla sivulla
    ${Uuskk}=    Get Text    xpath:/html/body/div[2]/div/table/tbody/tr[5]/td[2]
    ${Uuskk}=    Get Substring    ${Uuskk}    0    2
    Log To Console    ${Uuskk}
    Run Keyword And Continue On Failure    Should Be Equal   ${Kortinkk}    ${Uuskk}
    Sleep    1
    
    #Tarkistetaan, onko expiroitumisaika vuosi on oikein
    ${Uusvuos}=    Get Text    xpath:/html/body/div[2]/div/table/tbody/tr[5]/td[2]
    ${Uusvuos}=    Get Substring    ${Uusvuos}    4
    Log To Console    ${Uusvuos}
    Run Keyword And Continue On Failure    Should Be Equal   ${Kortinvuosi}    ${Uusvuos}
    Sleep    1

    #Tarkistetaan, että kokonaishinta on oikein
    ${Uuskokonaishinta}=    Get Text    xpath:/html/body/div[2]/div/table/tbody/tr[3]/td[2]
    Log To Console    ${Uuskokonaishinta}
    Run Keyword And Continue On Failure    Should Be Equal   ${hintakokonais}    ${Uuskokonaishinta}
    Sleep    1

    #Sulje selain
    Close Browser
