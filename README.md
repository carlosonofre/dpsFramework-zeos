# dpsFramework-zeos
Framework de Persistência - ORM [Delphi+Zeos Lib]

Estes framework tem por objetivo ajudar aos programadores Delphi/Pascal a implementar OO com mais eficiência em seus projetos.

Este projeto teve início quando comecei meus estudos de desenvolvimento para plataforma Android, conheci um framework feito por um colega, Douglas Cavalheiro(DroidPersistence),estudar este framework em outra linguagem me levou a duas conclusões importantes.

Mesmo que existam boas soluções no mercado, quase sempre precisamos de criar ajustes na ferramenta para nosso uso profissional.

Poderia criar um framework com a mesma funcionalidade em Delphi e assim aplicar as boas práticas da OO que são quase que obrigatórias nas outras linguagens.

A partir daí dediquei um pouco de esforço e tempo para criar este framework em Delphi e melhorar a qualidade dos códigos nesta IDE.

A documentação ainda é bem pobre pois tempo não é algo que disponho de muito no momento, porém procurei deixar o framework o mais simples possível.

Ele funciona com base na Zeos Lib versão 7 que dá suporte a diversos bancos de dados, principalmente os gratuitos (Firebird,SQLite,Postgre).

Como pode ser observado no código fonte as diversas rotinas foram implementadas com especificação de base quando necessário, mas devido a falta de tempo para a maioria dos caso só implementei o Firebird pois é o banco de dados que utilizo.

Com o passar do tempo eu troquei a biblioteca base de comunicação com o banco de dados por UniDAC e mantenho em um repositório privado, mas seguindo a sugestão de um amigo estou publicando a versão que tem a Zeos Lib como base de conexão.

Duvidas ou comentários conofresilva@gmail.com
