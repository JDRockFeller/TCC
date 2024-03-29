<%@page import="java.text.SimpleDateFormat"%>
<%@page import="br.edu.ifpr.irati.modelo.AgendamentoEntrevista"%>
<%@page import="br.edu.ifpr.irati.controle.ControleAgendamento"%>
<%@page import="br.edu.ifpr.irati.modelo.Usuario"%>
<%@page import="br.edu.ifpr.irati.modelo.Candidato"%>
<%@page import="br.edu.ifpr.irati.controle.ControleCandidato"%>
<%@page import="br.edu.ifpr.irati.controle.ControleFuncionario"%>
<%@page import="br.edu.ifpr.irati.modelo.Funcionario"%>
<%@page import="br.edu.ifpr.irati.modelo.Cargo"%>
<%@page import="br.edu.ifpr.irati.controle.ControleCargo"%>
<%@page import="br.edu.ifpr.irati.controle.ControleEntrevista"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8"/>
        <title>SGC Acome</title>
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
            <p> Clique <a href="index.jsp"> aqui</a> para fazer o login. </p> 
            <%} else { %>
            <center>
                <div class="container" style="width:50%;">
                    <form name="formulario" class="col s12" action="scripts/entrevistaCadastro.jsp" method="post">
                        <div class="card grey lighten-5">
                            <div class="card-content white-text ">

                                <div class="row">
                                    <div class="input-field col s12">
                                        <div class="input-field col s12">
                                            <select name="funcionario">
                                                <option value="" disabled selected>Escolha o Funcionario</option>
                                                <%ControleEntrevista controleEntrevista = new ControleEntrevista();

                                                    ControleFuncionario controleFuncionario = new ControleFuncionario();
                                                    for (Funcionario funcionario : controleFuncionario.consultarTodosFuncionarios()) {%>
                                                <option value="<%=funcionario.getIdPessoa()%>"><%=funcionario.getNomeCompleto()%></option>
                                                <%}%>
                                            </select>
                                            <label>Funcion�rio</label>
                                        </div>
                                    </div>
                                </div>

                                <!--Uma Combo Box contendo os cargos-->
                                <div class="row">
                                    <div class="input-field col s12">
                                        <div class="input-field col s12">
                                            <select name="cargo">
                                                <option value="" disabled selected>Escolha o Cargo</option>
                                                <% ControleCargo controleCargos = new ControleCargo();
                                                    for (Cargo cargo : controleCargos.consultarTodosCargos()) {%>
                                                <option value="<%=cargo.getIdCargo()%>"><%=cargo.getNomeCargo()%></option>
                                                <%}%>
                                            </select>
                                            <label>Cargo</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col s12">
                                        <div class="input-field col s12">
                                            <select name="candidato">
                                                <option value="" disabled selected>Escolha o Candidato</option>
                                                <%
                                                    ControleCandidato controleCandidatos = new ControleCandidato();
                                                    Candidato c = new Candidato();
                                                    for (Candidato candidato : controleCandidatos.consultarTodosCandidatos(c)) {%>
                                                <option value="<%=candidato.getIdPessoa()%>"><%=candidato.getNomeCompleto()%></option>
                                                <%}%>
                                            </select>
                                            <label>Candidato</label>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="input-field col s12">
                                        <div class="input-field col s12">
                                            <select name="sessao">
                                                <option value="" disabled selected>Escolha a Sess�o</option>
                                                <%
                                                    SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy");
                                                    ControleAgendamento controleAgendamento = new ControleAgendamento();
                                                    AgendamentoEntrevista agendamento = new AgendamentoEntrevista();
                                                    for (AgendamentoEntrevista a : controleAgendamento.consultarTodosAgendamentos(agendamento)) {
                                                %>
                                                <option value="<%=a.getIdSessao()%>">Sess�o do dia: <%= sdf.format(a.getDataSessao().getTime())%></option>
                                                <%
                                                    }%>
                                            </select>
                                            <label>Sess�o</label>
                                        </div>
                                    </div>
                                </div>           



                                <div class="row">
                                    <div class="input-field col s12">
                                        <div class="input-field col s12">
                                            <select name="faseTecnica">
                                                <option value="reprovado">Reprovado</option>
                                                <option value="aprovado">Aprovado</option>
                                            </select>
                                            <label>Fase T�cnica</label>
                                        </div>
                                    </div>
                                </div>


                                <div class="row">
                                    <div class="input-field col s12">
                                        <div class="input-field col s12">
                                            <select name="fasePsicologica">
                                                <option value="reprovado">Reprovado</option>
                                                <option value="aprovado">Aprovado</option>
                                                <option value="andamento">Em Andamento...</option>
                                            </select>
                                            <label>Fase Psicol�gica</label>
                                        </div>
                                    </div>
                                </div>





                                <button  class="waves-effect waves-light btn indigo" type="submit" name="salvar" onclick="return validar()"><span>Cadastrar</span></button>


                            </div>
                        </div>
                    </form>
                </div>
            </center>
            <% }%>

        </main>

        <footer>
            <jsp:include page="rodape.jsp" flush="true" />
        </footer>    
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0-beta/js/materialize.min.js"></script>
        <script>
                                    $(document).ready(function () {
                                        $('select').formSelect();
                                    });
        </script>
        <script>
            function validar() {
                if (document.formulario.funcionario.value == "") {
                    alert("Por favor, selecione o funcion�rio que presidir� a entrevista.");
                    return false;
                } else if (document.formulario.cargo.value == "") {
                    alert("Por favor, insira um cargo para a entrevista.");
                    return false;
                } else if (document.formulario.candidato.value == "") {
                    alert("Por favor, insira o candidato que far� a entrevista.");
                    return false;
                } else if (document.formulario.sessao.value == "") {
                    alert("Por favor, insira a sess�o que esta entrevista ocorrer�.");
                    return false;
                } else if (document.formulario.nomeCompleto.value == "") {
                    alert("Por favor, insira o seu nome completo.");
                    return false;
                } else if (document.formulario.cpf.value == "") {
                    alert("Por favor, insira o seu CPF.");
                    return false;
                } else if (document.formulario.rg.value == "") {
                    alert("Por favor, insira o seu RG.");
                    return false;
                } else if (document.formulario.sexo.value == "") {
                    alert("Por favor, insira o seu sexo.");
                    return false;
                } else if (document.formulario.endereco.value == "") {
                    alert("Por favor, insira o seu endere�o de e-mail.");
                    return false;
                } else if (document.formulario.curriculo.value == "") {
                    alert("Por favor, insira o seu curr�culo.");
                    return false;
                } else {
                    return true;
                }
            }
        </script>
    </body>
</html>
