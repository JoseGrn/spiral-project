.model small
.data
	cadena1 DB 'PARTE 1 $' 
	cadena2 DB 'PARTE 2 $'
	cadena3 DB 'Ingrese un numero $'
	tab DB '        $'
	abrirllave DB '<$'
	coma DB ' , $'
	cerrarllave DB '>$'
	yresiduo DB ' y el residuo es: $'
	numeroC db (0)	; se ingresa en el las centenas
	numeroD db (0) 	; se ingresa en el las decenas
	numeroU db (0)	; se ingresa en el las unidades
	numero db (0)	; se guarda el numero que la persona ingreso para la parte 1
	numerofinal db (0)	; se guarda el numero que la persona ingreso para la parte 2 video
	residuo db 0h	; son los residuos que se utilizaran al obtener por medio de las centenas, decenas y unidades el numero
	residuo2 db 0h
	residuo3 db 0h
	residuo4 db 0h
	cordenadax db 0h ; coodernada a imprimir x
	cordenaday db 0h ; coordenada a imprimir y
	incrementar db 0h ; contador
	incrementarup db 0h
	incrementarleft db 0h
	incrementarright db 0h
	incrementardown db 0h
	increup db 01h ; inicia en 1 porque empieza el primer arriba en un movimiento
	increleft db 02h ; inicia en 2 porque empieza el primer izquierda en dos movimientos
	increright db 01h ; inicia en 1 porque empieza el primer derecha en un movimiento
	incredown db 02h	; inicia en 2 porque empieza el primer abajo en dos movimientos
	
	con1 dw (1) ;contador de derecha y arriba (impares)
	con2 dw (2) ;contador de izquierda y abajo (pares)
	con3 db (0) ;contador de repeticiones
	contadorxd db 20h
	w dw (0) ;derecha y arriba
	h dw (0) ;izquierda y abajo
	color db (14)
;declaracion de variables
.stack 10h
.code

	programa: 
	;inicializar el programa
	MOV AX, @DATA			;Obtener direccion del segmento de datos
	MOV DS, AX 				; Asignar al Data Segment la direccion de la linea anterior
	
	;imprimir PARTE1
	MOV DX, offset cadena1
	MOV AH, 09h
	INT 21h
	XOR DX, DX
	
	CALL IMPRIMIRENTER
	CALL IMPRIMIRENTER
	
	;imprimir INGRESE
	MOV DX, offset cadena3
	MOV AH, 09h
	INT 21h
	XOR DX, DX
	
	
	CALL IMPRIMIRENTER
	CALL IMPRIMIRENTER
	
	;leer desde el teclado centena
	MOV AH, 01				;El valor leido  deberia estar en AL
	INT 21h 
	SUB AL, 30h				; restar 30h para obtener el valor real por el ascii
	MOV numeroC, AL			; asignar valor a la variables
	
	;leer desde el teclado decena
	MOV AH, 01				;El valor leido  deberia estar en AL
	INT 21h 
	SUB AL, 30h				; restar 30h para obtener el valor real por el ascii
	MOV numeroD, AL			; asignar valor a la variables
	
	;leer desde el teclado unidad
	MOV AH, 01				;El valor leido  deberia estar en AL
	INT 21h 
	SUB AL, 30h				; restar 30h para obtener el valor real por el ascii
	MOV numeroU, AL			; asignar valor a la variables
	
	XOR AL, AL ; limpiar registros
	
	CALL IMPRIMIRENTER 
	
	CALL HASTA ; ingresara las centenas, decenas unidades a la variable numero y numero final como numero real por el ascii
	
	CALL	IMPRIMIRPARTE1 ; se imprime el primer numero con su coordernada x y y 
	
	
	INICIO:
	;iniciar
	MOV CL, increright ; se inicia en derecha y se coloca en CL la variable increright
	DERECHA:
	CALL RIGHT ; incrementa la coordenada x
	CALL	IMPRIMIRPARTE1 ; imprime el siguiente numero con su coordenada x y y
	LOOP DERECHA ; realiza un loop en derecha la cantidad de veces que se le ingreso a CL
	CALL INCREMENTARDERECHA ; incrementa en 2 a ingreright
	
	
	MOV CL, increup ; realiza los movimientos hacia arriba y se coloca en CL la variable increup 
	ARRIBA: 
	CALL UP ; incrementa coordenada y
	CALL	IMPRIMIRPARTE1 ; imprime el siguiente numero con su coordenada x y y
	LOOP ARRIBA ; realiza un loop en Arriba la cantidad de veces que se le ingreso a CL
	CALL INCREMENTARARRIBA ; incrementa en 2 a ingreup
	
	
	MOV CL, increleft ; realiza los movimientos hacia izquierda y se coloca en CL la variable increleft
	IZQUIERDA:
	CALL LEFT ; decrementa coordenada x
	CALL	IMPRIMIRPARTE1 ; imprime el siguiente numero con su coordenada x y y
	LOOP IZQUIERDA ; realiza un loop en Izquierda la cantidad de veces que se le ingreso a CL
	CALL INCREMENTARIZQUIERDA ; incrementa en 2 a ingreleft
	
		
	MOV CL, incredown ; realiza los movimientos hacia abajo y se coloca en CL la variable increleft
	ABAJO:
	CALL DOWN ; decrementa coordenada y
	CALL	IMPRIMIRPARTE1 ; imprime el siguiente numero con su coordenada x y y
	LOOP ABAJO ; realiza un loop en Abajo la cantidad de veces que se le ingreso a CL
	CALL INCREMENTARABAJO ; incrementa en 2 a ingredown
		
	CMP numero, 0 ; compara que numero es 0
	JG INICIO ; si no es 0 se va a Inicio sino sigue 
	
	Finalizar:
	
		;inicio del proceso de impresion de espiral
			MOV AH, 01 ;aqui se hace una pausa para suponer una lectura pero es para hacer una pausa en el proceso
			INT 21h 
		
			mov ax,@data
			mov ds,ax
		 
		;CONVERSION A MODO GRAFICO
			mov ah,00
			mov al,12h ;en este espacio del codigo se hace la seleccion a modo grafico
			int 10h

			mov dx,250 ;asignacion eje y
			mov cx,250 ;asignacion eje x
			
			;derecha
		pix:mov ah,0ch ;pinta un pixel
			mov al,3 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			inc con3 ;se incrementa el contador de cuantas repeticiones llevamos
			
		rep1:
			inc cx ;se incrementa una vez la coordenada x
			mov ah,0ch ;pinta un pixel
			mov al,4 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			dec contadorxd ;contador de cuantos pixeles hay que pintar
			cmp contadorxd, 0h ;validacion de si ya llego a 0 el contador de pixeles
			JNE rep1 ;salto de repeticion del metodo
			
			mov contadorxd, 20h ;se le asigna nuevamente el valor correspondiente al contador de pixeles
			inc cx ;incrementa una vez la coordenada x
			mov bl, numerofinal ;le asignamos a bl el valor de la variable numerofinal
			cmp con3,bl ;hacemos una validacion de si ya llegamos a la cantidad de numeros
			jge Salto2 ;salto al metodo salto2
			inc w ;incremento en la variable w
			mov bx, con1 ;asignacion del valor de con1 a bx
			cmp w,bx ;validacion de si ya llegamos a la cantidad de impresion de numeros necesarios en esta ronda
			jne pix ;salto a repeticion del metodo
			mov w, 0 ;asignacion de 0 a la variable w

		Salto2:
			mov bl, numerofinal ;asignacion de numerofinal a bl
			cmp con3,bl ;comparacion de si ya llegamos a la cantidad de numeros 
			jge Salto3 ;salto a salto3

			;arriba
		pix2:mov ah,0ch ;pinta un pixel
			mov al,3 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			inc con3 ;se incrementa el contador de cuantas repeticiones llevamos
			dec dx ;decremento a la coordenada en y
		rep2:
			mov ah,0ch ;pinta un pixel
			mov al,4 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			dec dx ;decremento en la coordenada y
			dec contadorxd ;contador de cuantos pixeles hay que pintar
			cmp contadorxd,0h ;validacion de si ya llego a 0 el contador de pixeles
			JNE rep2 ;salto de repeticion del metodo
			
			mov contadorxd, 20h ;se le asigna nuevamente el valor correspondiente al contador de pixeles
			mov bl, numerofinal ;asignacion del valor de numerofinal a bl
			cmp con3,bl ;comparacion de si ya llegamos a la cantidad de numeros
			jge Salto3 ;salto a salto3
			inc w ;incremento en la variable w
			mov bx, con1 ;asignacion de con1 en bx
			cmp w,bx ;validacion de si ya llegamos a la cantidad de impresion de numeros necesarios en esta ronda
			jne pix2 ;salto a la repeticion del metodo
			mov w, 0 ;asignacion del valor 0 en la variable w
			inc con1 ;incremento de con1
			inc con1 ;incremento de con1

		Salto3:
			mov bl, numerofinal ;asignacion de numerofinal a bl
			cmp con3,bl ;validacion de si ya llegamos a la cantidad de numeros
			jge Salto4 ; salto a salto4

			;izquierda
		pix3:mov ah,0ch ;pinta un pixel
			mov al,3 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			inc con3 ;se incrementa el contador de cuantas repeticiones llevamos
			dec cx ;decremento en la coordenada x
		rep3: 
			mov ah,0ch ;pinta un pixel
			mov al,4 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			dec cx ;decremento en la coordenada x
			dec contadorxd ;contador de cuantos pixeles hay que pintar
			cmp contadorxd, 0h ;validacion de si ya llego a 0 el contador de pixeles
			JNE rep3 ;salto de repeticion del metodo
			
			mov contadorxd, 20h ;se le asigna nuevamente el valor correspondiente al contador de pixeles
			mov bl, numerofinal ;asignacion del valor de numerofinal a bl
			cmp con3,bl ;validacion de si ya llegamos al numero
			jge Salto4 ;salto a salto4
			inc h ;incremento en la variable h
			mov bx, con2 ;asignacion de la variable con2 en bx
			cmp h,bx ;validacion de si ya llegamos a la cantidad de impresion de numeros necesarios en esta ronda
			jne pix3 ;salto a pix3
			mov h, 0 ;asignacion del valor 0 en la variable h

		Salto4:
			mov bl, numerofinal ;asignacion del valor de numerofinal en bl
			cmp con3,bl ;validacion de si ya llegamos al numero
			jge final ;salto a final

			;abajo
		pix4:mov ah,0ch ;pinta un pixel
			mov al,3 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			inc con3 ;se incrementa el contador de cuantas repeticiones llevamos
			inc dx ;incremento en la coordenada y
		rep4:
			mov ah,0ch ;pinta un pixel
			mov al,4 ;se selecciona color que se pintara
			mov bh,0h ;es la pagina 0
			int 10h
			inc dx ;incremento en la coordenada y
			dec contadorxd ;contador de cuantos pixeles hay que pintar
			cmp contadorxd, 0h ;validacion de si ya llego a 0 el contador de pixeles
			JNE rep4 ;salto de repeticion del metodo
			
			mov contadorxd, 20h ;se le asigna nuevamente el valor correspondiente al contador de pixeles
			mov bl, numerofinal ;asignacion de numerofinal en bl
			cmp con3,bl ;validacion de si ya llegamos al numero
			jge final ;salto a final
			inc h ;incremento en la variable h
			mov bx, con2 ;asignacion del valor de con2 en bx
			cmp h,bx ;validacion de si ya llegamos a la cantidad de impresion de numeros necesarios en esta ronda
			jne pix4 ;salto a repeticion del metodo
			mov h, 0 ;asignacion del valor 0 a la variable h
			inc con2 ;incremento en la variable con2
			inc con2 ;incremento en la variable con2
			mov bl, numerofinal ;asignacion de numerofinal en bl
			cmp con3,bl ;validacion de si ya llegamos al numero
			jl salto ;salto a salto
			
		final:				;Finalizar el programa
			jmp final ;bucle infinito para mostrar bien el espiral
			MOV AH, 4CH ;enviar parametro de interrupcion
			INT 21h
			
		salto:
			jmp pix ;retorno al inicio del programa de impresion de espiral
	
	
	IMPRIMIRPARTE1:
		DEC numero ; decrementa la variable numero
		CMP numero, 0 ; verifica si numero es 0
		JE Finalito ; si lo es salta a finalito que se ira luego a finalizar en donde empieza el espiral
		CALL IINCREMENTAR ; incrementa la variable incrementar
		CALL TABB ; imprime en tabulador
		CALL IMPRIMIRLLAVEA ; imprime <
		CALL CORDENADAXI ; imprime la coordenada x
		CALL IMPRIMIRCOMA ; imprime una ,
		CALL CORDENADAYI ; imprime la coordenada y
		CALL IMPRIMIRLLAVEC ; imprime >
		CALL IMPRIMIRENTER ; imprime un enter
	RET
	
	Finalito:
		jmp Finalizar ; se ira a dibujar la espiral
	
	CORDENADAXI:
		CMP cordenadax, 0h ; verifica si la coordenada es positiva
		JGE XPOSITIVO  ; si es positiva se va a xpositivo en donde imprimira la coordenada x
		CALL imprimirnegx ; si es negativo ira a la etiqueta imprimirnegx
		RET
		XPOSITIVO: 
		call saltosx ; imprime la coordenada x positiva
	RET
	
	saltosx:
		MOV DL,cordenadax ; mueve la coordenada x positiva
		ADD DL, 30h ; le agrega 30h para que muestre el numero
		MOV AH, 02h ; imprime en pantalla
		INT 21h
	RET
	
	imprimirnegx:
	;imprimir negativo -
		MOV DL,2Dh ; coloca el simbolo -
		MOV AH, 02h
		INT 21h
		
		MOV DL, cordenadax ;mueve la coordenada x negativa a DL 
		NEG DL ; niega el numero negativo de la coordenada x para que sea positivo
		ADD DL, 30h ; imprime la coordenada x 
		MOV AH, 02h
		INT 21h
	RET
	
	
	CORDENADAYI:
		CMP cordenaday, 0h ; verifica si la coordenada es positiva
		JGE YPOSITIVO ; si es positiva se va a ypositivo en donde imprimira la coordenada y
		CALL imprimirnegy ; si es negativo ira a la etiqueta imprimirnegy
		RET
		YPOSITIVO:
		call saltosy ; imprime la coordenada y positiva
	RET
	
	saltosy:
		MOV DL,cordenaday ; mueve la coordenada y positiva
		ADD DL, 30h ; le agrega 30h para que muestre el numero
		MOV AH, 02h ; imprime en pantalla
		INT 21h
	RET
	
	imprimirnegy:
	;imprimir negativo -
		MOV DL,2Dh ; coloca el simbolo -
		MOV AH, 02h
		INT 21h
	
		MOV DL, cordenaday ;mueve la coordenada y negativa a DL
		NEG DL ; niega el numero negativo de la coordenada y para que sea positivo
		ADD DL, 30h ; imprime la coordenada y
		MOV AH, 02h
		INT 21h
	RET
	
	
	
	
	
	IINCREMENTAR:
		INC incrementar	;incrementa la varible incrementar
		MOV AL, incrementar ; mueve la variable a AL
		CALL imprimir3digitos ; recibe la variable AL e imprime en 3 digitos el numero incrementar
	RET
	
	INCREMENTARARRIBA: ; incrementa 2 veces increup
		INC increup 
		INC increup 
	RET
	
	INCREMENTARABAJO: ; incrementa 2 veces incredown
		INC incredown
		INC incredown
	RET
	
	INCREMENTARDERECHA: ; incrementa 2 veces increright
		INC increright
		INC increright
	RET
	
	INCREMENTARIZQUIERDA: ; incrementa 2 veces increleft
		INC increleft
		INC increleft
	RET
	
	RIGHT: ; incrementa la coordenada x cuando es derecha
		INC cordenadax
	RET
	
	LEFT: ; decremetna la coordenada x cuando es izquierda
		DEC cordenadax
	RET
	
	UP: ; incrementa la coordenada y cuando es arriba
		INC cordenaday
	RET
	
	DOWN: ; decrementa la coordenada y cuando es abajo
		DEC cordenaday
	RET
	
	HASTA:
		MOV AL, numeroC ; coloca la centena en AL
		MOV Bl, 64h ; mueve a bl 100 en decimal
		MUL BL 	; multiplica AL con BL, es decir 100 x centena
		MOV DL, AL ; mueve el resultado a DL
		XOR AL, AL ; limpia AL
		MOV AL, numeroD ; coloca la decena en AL
		MOV BL, 0AH ; mueve a bl 10 en decimal
		MUL BL ; multiplica AL con BL, es decir 10 x decena
		ADD DL, AL ; el resultado esta en AL y se suma a DL 
		ADD DL, numeroU ; el resultado se suma con el numero en unidades
		MOV numerofinal,DL ; el numero real se ingresa a numerofinal que se utilizara en el area del espiral
		ADD DL, 01h ; le agrega 1 a DL porque en inicio se inicia decrementando numero
		MOV numero, DL ; se mueve DL a numero.
	RET	
	
	
	
	imprimir3digitos:
		AND AX, 0FFh ; limpia el registro de AX que no se esta utilizando
		MOV BL, 64H ; se coloca 100 en decimal a BL
		;Asumir que el resultado esta en AL
		DIV BL 	;dividir entre 10
		;cociente en AL -> CENTENAS, residuo AH -> DECENAS 
		MOV residuo3, AH
		
		
		;imprimir centena
		MOV DL, AL 
		ADD DL, 30h
		MOV AH , 02h
		INT 21h
		
		;se coloca el residuo en AL para utilizarlo en la llamada de imprimir2digitos.
		MOV AL, residuo3
		CALL imprimir2digitos
	RET
	
	imprimirneg:
	;imprimir negativo -
		MOV DL,2Dh
		MOV AH, 02h
		INT 21h
	RET
	
	imprimir2digitos:
		AND AX, 0FFh
		MOV BL, 0AH ; se coloca 10 en decimal en BL
		;Asumir que el resultado esta en AL
		DIV BL 	;dividir entre 10
		;cociente en AL -> decenas, residuo AH -> unidades
		MOV residuo2, AH ; se imprime las decenas
		MOV AH , 02h
		MOV DL, AL 
		ADD DL, 30h
		INT 21h
		
		; se imprime las unidades
		MOV DL, residuo2 
		ADD DL, 30h
		INT 21h
	RET
	
	IMPRIMIRENTER:
		;imprimir enter
		MOV DL,0Ah
		MOV AH, 02h
		INT 21h
	RET
	
	
	TABB:
		;imprimir ESPACIOS
		MOV DX, offset tab
		MOV AH, 09h
		INT 21h
		XOR DX, DX
	RET
	
	IMPRIMIRLLAVEA:
		;imprimir <
		MOV DX, offset abrirllave
		MOV AH, 09h
		INT 21h
		XOR DX, DX
	RET
	
	IMPRIMIRLLAVEC:
		;imprimir >
		MOV DX, offset cerrarllave
		MOV AH, 09h
		INT 21h
		XOR DX, DX
	RET
	
	IMPRIMIRCOMA:
		;imprimir ,
		MOV DX, offset coma
		MOV AH, 09h
		INT 21h
		XOR DX, DX
	RET
	

END programa