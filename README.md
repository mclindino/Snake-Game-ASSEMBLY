### Snake-Game-ASSEMBLY


	Foi desenvolvido um jogo baseado no clássico Snake. Temos como protagonista uma cobra que precisa comer maçãs espalhadas pelo cenário. Diferentemente do original, a cada maçã comida o jogador ganha um ponto, e a cobra não aumenta seu tamanho. O objetivo do jogo é comer o máximo de maçãs possível. A cobra morre se encostar nos extremos norte e sul do cenário, sinalizados com a cor vermelho.   




1. Configurando o MARS:
	
	Certificar-se de habilitar as opções Delayed Branching e Permit Extended (pseudo) Instructions and Formats.
	Antes de iniciar o jogo, abrir o bitmap display, definindo os seguintes parametros:
		- Unit Width in Pixels = 4;
		- Unit Height in Pixels = 4;
		- Display Width in Pixels = 512;
		- Display Height in Pixels = 256;
		- Base addres for display = 0x10010000 (static data);
		- Conectar ao MIPS;
	Após calibrar o bitmap display, abrir o keyboard and display MMIO simulator e conectar ao MIPS. 
	Compilar o código e executá-lo.




2. Como jogar:
	
	W,A,S,D movimentam a cobra. As teclas devem ser digitadas na segunda janela do  keyboard and display MMIO simulator.




3. Registradores:
	
	- $t0: Primeira posição de memória, utilizada na manipulação do Bitmap.	
	- $t1: Quantidade de pixeis da tela do Bitmap.
	- $t2: Armazena em hexadecimal a cor preto.
	- $t3: Armazena em hexadecimal a cor branco.
	- $t4: Monitora a leitura do teclado, gravando na memória um valor binário.
	- $t5: Armazena o caractere lido do teclado na memória.
	- $t6: Carrega o valor da célula de memória em $t4.
	- $t7: Carrega o caractere na célula de memória em $t5.
	- $t8: Cópia da posição da cabeça da cobra.
	- $t9: Auxiliar geral.
	- $s0: Armazena a posição da cauda da cobra.
	- $s1: Armazena a posição da cabeça da cobra.
	- $s2: Valor correspondente ao tamanho da cobra.
	- $s3: Direção atual da cobra.
	- $s4: Valor pseudoaleatório que representa a posição da maçã.
	- $s5: Auxiliar geral.
	- $s6: Armazena em hexadecimal a cor vermelho.
