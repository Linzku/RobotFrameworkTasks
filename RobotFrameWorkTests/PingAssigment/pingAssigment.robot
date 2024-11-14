#Made by LL
*** Settings ***
Library    String
Library    OperatingSystem
Library    Collections

*** Test Cases ***
Lue webpage.txt tiedot RF kayttoon

#haetaan webpages.txt tiedostosta sivustojen osoitteet
    ${webpages}=    Get File    RobotFrameworkTests/PingAssigment/webpages.txt

#tee textitiedoston sisällöistä listaan osoitteet listan itemeiks  
    @{Websites}=    Split String    ${webpages}

    Log    ${Websites}

    Set Global Variable    ${Websites}

*** Test Cases ***
Pingaa osoitteet hakien ip ja aika jonka tulisi olla alle 50ms

#Ota osoitteet sisältävän listan pituus ylös For looppia varten
    ${lengthweb}=    Get Length    ${Websites}

#For looppi käymään läpi osoite listan osoitteet
    FOR    ${counter}    IN RANGE    ${lengthweb}
        Log    ${counter}
        
    #pingaa sivut loopissa ja laita pingin tulos uuteen listaan sisällöksi
        ${output}=    Run And Return Rc And Output    ping ${Websites}[${counter}]
        @{weblist1}=    Split String    ${output}[1]
        
        #Loggaa uuden listan sisältö, jotta voi tietää mistä löytyy ip-osoite ja average aika
        Log    ${weblist1}
        
        #uuden listan pituus ylös, josta vähennetään 1, jotta voidaan käyttää sitä listan viimeisen itemin hakuun
        ${length}=    Get Length    ${weblist1}
        Log    ${length}
        ${numero}=    Set Variable    ${length-1}

        ${ping2}=    Set Variable    ${weblist1}[${numero}]

        #Sitten haetaan ip-osoitetta aluksi tallentamalla sen jälkeinen listan itemin indeksi numero (koska helpompi se etsiä kuin ip)
        ${index}=    Get Index From List    ${weblist1}    with
        Log    ${index}

        #Sitten vain vähennetään indeksistä yksi, jotta indeksi on oikeassa kohtaa ja käytetään sitä listasta itemin hakuun
        ${index}=    Evaluate    ${index}-1
        ${ping}=    Set Variable    ${weblist1}[${index}]
        Log   ${ping}${ping2}

        #verrataan vielä, että keskimääräinen ping aika on alle 50ms
        ${ping2Nro}=    Set Variable    ${ping2}[:-2]

        ${ping2NroNumeroksi}=    Convert To Number    ${ping2Nro}

        Should Be True    ${ping2NroNumeroksi} < 50
        #This does works also
        #Run Keyword If    ${ping2NroNumeroksi} < 50    Fail

        #Lopuksi lisätään uuteen teksti tiedostoon ip-osoite ja aika 
        Append To File    RobotFrameworkTests/PingAssigment/pingedresults.txt    IP-osoite= ${ping} ja pingauksen keskimääräinen aika= ${ping2}\n
    
    #Loopataan ylläoleva ja listaan on sitten saatu kaikki mitä pitikin
    END
