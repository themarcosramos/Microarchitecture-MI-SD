# Microarchitecture-MI-SD
Repositório que contém os projetos desenvolvidos pelo do modulo integrador de sistemas digitais dos semestres de 2019.1, do curso de [engenharia de computação](http://www.ecomp.uefs.br/) da instituição de ensino superior [Universidade Estadual de Feira de Santana - UEFS](http://www.uefs.br/).

## 1 Microarchitecture simples (Primeiro problema do módulos integrado de sistema digitais)
  >## Objetivo 
  >Desenvolver uma IHM que utilize os botões como entrada, LEDs e um
display LCD como saídas. O sistema foi desenvolido e implementado em FPGA, usando o processador NIOS II. 
>
## 2 Microarchitecture IOT (Segundo problema do módulos integrado de sistema digitais)
 >## Objetivo 
  >Desenvolver um sistema digital que publique mensagens em um Broker MQTT. A mensagem a ser transmitida será escolhida através da IHM já desenvolvida. 
 >
  > > > Observação :  **Pequeno problema na realização do terceiro passo do handshake, no processo de inicializar a comunicação com o broker**

## 3 Microarchitecture JogoPong (Terceiro problema do módulos integrado de sistema digitais)
  >## Objetivo 
   >Desenvolver um sistema digital   para validar o funcionamento do processador baseado no jogo pongo

## Ferramamentas ultilizadas 
 > * [Altera Quartus II 13.0 service Pack 1](http://fpgasoftware.intel.com/13.0sp1/)
 > * Placa Mercurio IV da [Familia Cyclone IV](https://www.intel.com/content/www/us/en/products/programmable/fpga/cyclone-iv.html) com o Chip EP4CE30F23C7.
 > * Módulo[ Esp8266](https://www.espressif.com/en/products/hardware/esp8266ex/overview).
 > * Software [ Altera Monitor Program](https://www.intel.com/content/www/us/en/programmable/support/training/university/materials-software.html).


## Desenvolvedores 
 > * [Marcos Ramos](https://github.com/themarcosramos/)
 > * [Gadiel xavier](https://github.com/gadielxavier/)
 > * [Nágila Rocha](https://github.com/nagilarocha/)
 > * [Gilvanei bispo](https://github.com/gilvaneibispo/)
 >
  >> sobre orientação da professora  **Ana Cláudia Fiorin**
 >

## Como uilizar 
 > 1. Abrir o Altera Quartus II 13.0 SP1;
 > 1. Em File -> Open Project;
 > 1. Selecionar a Microarchitecture;
 > 1. Abrir o arquivo microarquiteturaGp3;
 > 1. Executar a compilação do Projeto;
 > 1. Descarregar na FPGA;
 > 1. Abrir o Altera Monitor;
 > 1. Abrir o arquivo teste.ncf;
 > 1. Clicar em Actions -> Compile & Load.