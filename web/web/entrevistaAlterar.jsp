
<%@page import="br.edu.ifpr.irati.modelo.Usuario"%>
<%@page import="br.edu.ifpr.irati.modelo.Candidato"%>
<%@page import="br.edu.ifpr.irati.modelo.Cargo"%>
<%@page import="br.edu.ifpr.irati.controle.ControleCargo"%>
<%@page import="br.edu.ifpr.irati.modelo.Funcionario"%>
<%@page import="br.edu.ifpr.irati.modelo.Entrevista"%>
<%@page import="br.edu.ifpr.irati.controle.ControleEntrevista"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Alterar</title>
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
                if (!logado || u.getTipoUsuario().equals("candidato")) {
            %> <p> Acesso Negado </p>
            <p> Clique <a href="login.jsp"> aqui</a> para fazer o login. </p> 
            <%} else { %>
            <%
                int idEntevista = Integer.parseInt(request.getParameter("idEntrevista"));
                ControleEntrevista e = new ControleEntrevista();
                Entrevista ei = e.consultarEntrevistaPorId(idEntevista);
            %>

            <div class="row">
                <form class="col s12" action="scripts/entrevistaAlterar.jsp" method="post">

                    <div class="row">
                        <div class="input-field col s12">
                            <input placeholder="" id="first_name" type="hidden" name="idEntrevista" value="<%= idEntevista%>"class="validate"/>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s12">
                            <div class="input-field col s12">
                                <select name="funcionario">

                                    <%

                                        Funcionario f = ei.getFuncionarioMinistrante();%>
                                    <option value="<%=f.getIdPessoa()%>"><%=f.getNomeCompleto()%></option>

                                </select>
                                <label>Funcionario</label>
                            </div>
                        </div>
                    </div>


                    <div class="row">
                        <div class="input-field col s12">
                            <div class="input-field col s12">
                                <select name="cargo">

                                    <%
                                        ControleCargo controleCargo = new ControleCargo();
                                        for (Cargo c : controleCargo.consultarTodosCargos()) {%>
                                    <option value="<%=c.getIdCargo()%>"><%=c.getNomeCargo()%></option>
                                    <%}%>
                                </select>
                                <label>Cargo</label>
                            </div>
                        </div>
                    </div>

                    <!--Uma Combo Box contendo os benditos Candidatos-->
                    <div class="row">
                        <div class="input-field col s12">
                            <div class="input-field col s12">
                                <select name="candidato">

                                    <%
                                        Candidato c = ei.getCandidato();
                                    %>
                                    <option value="<%=c.getIdPessoa()%>"><%=c.getNomeCompleto()%></option>

                                </select>
                                <label>Candidato</label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s12">
                            <div class="input-field col s12">
                                <select name="faseTeorica">


                                    <option value="aprovado" >Aprovado</option>

                                    <option value="reprovado" >Reprovado</option>

                                </select>
                                <label>Andamento na Entrevista Prática</label>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col s12">
                            <div class="input-field col s12">
                                <select name="fasePsicologica">


                                    <option value="aprovado">Aprovado</option>

                                    <option value="reprovado">Reprovado</option>


                                </select>
                                <label>Andamento na Entrevista Psicológica</label>
                            </div>
                        </div>
                    </div>

                    <input type="submit" name="salvar" value="Alterar!" class="waves-effect waves-indigo  btn-flat"/>

                </form>
            </div>
            <% }%>
        </main>

        <footer>
            <jsp:include page="rodape.jsp" flush="true" />
        </footer>                
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js">

        </script>  
        <script>
            $(document).ready(function () {
                $('select').formSelect();
            });

        </script>
    </body>
</html>
