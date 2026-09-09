# Maik Bastian
ich hatte in den letzten Wochen Gelegenheit mit **Codex** (und GPT 5.5) zur Erstellung der M-209-App für CTO zu experimentieren.

Das war mein initialer Prompt zur Erstellung des Grundgerüsts:
```
I want to add a new CTO app that will allow a user to encrypt and decrypt texts using the M-209 cipher machine.

Could you add this new app using the guidelines outlined in the docs/ folder as well as the provided components for common use cases?

For examples of useful layouts you could look into existing implementations like the caesar cipher.
```

Davon abgesehen habe ich keine Vorarbeit geleistet. Der Agent musste sich also am bestehenden Projekt orientieren.

Die erstellte Implementierung hat sich auch an den beschriebenen Anforderungen orientiert. D.h. die Anwendung sah ähnlich unseren bisherigen historischen Verschlüsselungen aus. Die Ordnerstruktur und der Eintrag in der `ctoapps.json` waren korrekt und haben sich an unserer typischen Struktur orientiert.  Die Implementierung der Tests war sehr knapp, aber ansonsten sah der Algorithmus korrekt aus. (Hier habe ich bisher keinen Fokus drauf gelegt, da ich mit dem Agenten mehr am Design und Layout arbeiten möchte und später eine eigene Implementierung des Algorithmus hinterlegen werde.)

Danach habe ich mehr daran gearbeitet eine Art visuelle Repräsentation der Machine für die Eingabe des Schlüssels umzusetzen. Also eine HTML-Form, deren Layout der eigentlichen Chiffriermaschine ähnelt. Ich wollte zunächst herausfinden, ob das Modell in der Lage ist dies einigermaßen selbständig umzusetzen. Dies gelang aber nicht, da es auch nach mehrmaligen Versuchen Schwierigkeiten hatte das Layout der Maschine richtig zu erfassen und dieses mit einfachen HTML-Elementen zu repräsentieren.
Daraufhin habe ich mich mit dem Agenten über sehr viele Iterationen dem Design angenähert. Interessanterweise musste ich das Modell häufiger auf bestimmte Komponenten von Chakra UI hinweisen. Andernfalls hat es bestehende Komponenten aufwändig selbst implementiert. 

-----

> Mit visuellen Repräsentationen kenne ich mich noch nicht so aus. Was hast du der KI dazu zur Verfügung gestellt? 
Ich habe hier zunächst auch nur meine Anforderungen geschildert. Anhand der Logs konnte ich sehen, dass das Modell im Internet nachgeschlagen hat. Es hat dann u.a. mit der folgenden Seite gearbeitet: https://www.cryptomuseum.com/crypto/hagelin/m209/index.htm. Anscheinend wurden dort auch die Bilder geladen.
Ich habe später auch explizit URLs zu Bildern der Maschine in den Prompt integriert. Z.B.: https://www.nf6x.net/wp/wp-content/uploads/2013/03/pins-lugs-1.png. In der Ausgabe hat sich das Modell auch auf diese Bilder bezogen. In wie weit es diese "verstanden" hat, bin ich mir aber nicht sicher. 🙂 Beispielsweise wurden die Walzen zunächst als kreisförmige Felder und die Stangen nur mit jeweils 2 Textfeldern umgesetzt. Ebenso passte das allgemeine Layout nicht zur Maschine (Stangen und Walzen vertauscht, etc.) Zwischenzeitlich hatte ich auch damit experimentiert, die mechanische Kuppelung zwischen den Komponenten darstellen zu lassen. Da diese in den Beschreibungen aber kaum vorkommen, konnte ich das Modell auch nicht dazu bewegen etwas zu generieren. Von daher bin ich mir nicht sicher, wie sehr die Bilder tatsächlich mit einbezogen werden.

> Ich werde (wie oben erwähnt) auch Skills/Tools/.md-Dateien entwickeln, die man nachher als "Setup" nutzen kann, um mit einem "schlaueren" Agent entwickeln zu können.
Mir war letztens auf der Chakra UI-Dokumentation der Abschnitt "AI for Agents" aufgefallen; u.a. https://www.chakra-ui.com/docs/get-started/ai/llms. Ich kenne mich zu wenig mit den Agenten aus, aber vielleicht kannst du diese Features auch integrieren. Zumindest Claude scheint nämlich nicht auf die Dokumentation von Chakra zurückzugreifen. Meistens wenn ich um eine bestimmte Komponente gebeten habe, hat das Modell den Quellcode aus den `node_modules` gelesen. 