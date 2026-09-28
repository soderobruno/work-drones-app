# WORK DRONES GEO — Central de Operações

Protótipo funcional local, criado para validar a interface e o fluxo operacional.

## Recursos
- Login de demonstração
- Dashboard de prontidão
- Banco de documentos com validade e cadastro de arquivo
- Alertas de vencimento
- Cadastro de operações
- Histórico de operações e ações
- Cadastro de aeronaves
- Checklist pré-voo
- Seleção de operação e geração automática de ARO
- Impressão/salvamento da ARO em PDF pelo navegador
- Persistência local via localStorage

## Como abrir
Abra `index.html` em um navegador moderno.

Login de demonstração:
- e-mail: admin@workdronesgeo.com
- senha: workdrones

## Importante
Esta é a primeira versão funcional/protótipo. O login e o armazenamento são locais no navegador e NÃO devem ser usados como segurança de produção.

Para transformar em sistema real:
1. autenticação segura;
2. banco PostgreSQL/Supabase;
3. armazenamento privado de PDFs;
4. permissões por usuário;
5. logs de auditoria;
6. notificações por e-mail/WhatsApp;
7. assinatura/validação documental;
8. geração de PDFs padronizados;
9. backups;
10. revisão dos modelos de ARO/checklists conforme a regulamentação aplicável à operação.

O conteúdo da ARO é um modelo operacional e precisa ser conferido/adaptado antes do uso em missão real.
