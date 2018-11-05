
<%@page import="br.edu.ifpr.irati.modelo.Usuario"%>
<%@page import="br.edu.ifpr.irati.modelo.Candidato"%>
<%@page import="br.edu.ifpr.irati.controle.ControleCandidato"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
       
            
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Candidatos</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/css/materialize.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.3.1.min.js" integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="  crossorigin="anonymous"></script>
    <% 
        session = request.getSession();
        Usuario u = (Usuario) session.getAttribute("usuario");
        boolean logado = false;
               if (u != null) {
               logado = true;
             }
         %>
    
    </head>
    <body>
        <header>
            <jsp:include page="cabecalho.jsp" flush="true" />
        </header>

        <main>
            <%
                if(!logado || u.getTipoUsuario().equals("candidato")){
                   %> <p> Acesso Negado </p>
                    <p> Clique <a href="index.jsp"> aqui</a> para fazer o login. </p> 
             <%} else{ %>
             <div class="row" white-text>
             <table class="highlight" 
                <thead>
                    <tr>
                        <th>Nome Completo</th>
                        <th>Cargo Desejado</th>
                        <th>Email</th>
                        <th>Escolaridade</th>
                    </tr>
                </thead>


                <tbody>
                    <%
                        ControleCandidato controleCandidato = new ControleCandidato();
                      Candidato candidato = new Candidato();
                        for (Candidato c : controleCandidato.consultarTodosCandidatos(candidato)) {%>
                    <tr>
                        <%----%><td><%=c.getNomeCompleto()%></td>
                        <%----%><td><%=c.getCargoDesejado()%></td>
                                <td><%=c.getEnderecoEmail()%></td>
                                <td><%=c.getEscolaridade()%></td>
                        <td>
                            <a href="candidatoAlterar.jsp?idCandidato=<%=c.getIdPessoa()%>" class="waves-effect waves-indigo darken-3 btn-flat "><i class="material-icons right">refresh</i>Alterar</a>
                        </td>
                        <td><a href="scripts/excluirCandidato.jsp?idCandidato=<%=c.getIdPessoa()%>" class="waves-effect waves-grey btn-flat"><i class="material-icons right">delete</i>Excluir</a>
                        </td>
                       
                    </tr>
                </tbody>
                <%}%>

            </table>
            </div>
            <a href="candidatoCadastro.jsp" class="waves-effect waves-indigo darken-3 btn-flat "><i class="material-icons right">create</i>Cadastrar</a>
         <% } %>
        </main>

        <footer>
            <jsp:include page="rodape.jsp" flush="true" />
        </footer>                
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>        
    </body>
</html>