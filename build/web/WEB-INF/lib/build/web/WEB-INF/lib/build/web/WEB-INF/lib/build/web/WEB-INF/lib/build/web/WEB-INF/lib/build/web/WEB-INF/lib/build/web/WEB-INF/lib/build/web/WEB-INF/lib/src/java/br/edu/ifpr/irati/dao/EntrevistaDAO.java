/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.edu.ifpr.irati.dao;

import br.edu.ifpr.irati.modelo.Entrevista;
import gerais.HibernateUtil;
import org.hibernate.Query;
import org.hibernate.Session;

/**
 *
 * @author Altai
 */
public class EntrevistaDAO {
    
    public Entrevista buscarPorIdCandidato(int idCandidato){
        Session session = HibernateUtil.getSessionFactory().openSession();
        String hql = "from entrevista where candidato_idPessoa = "+idCandidato+" ";
        Query query = session.createQuery(hql);
        query.setMaxResults(1);
        Entrevista entrevista = (Entrevista) query.uniqueResult();        
        session.clear();
        session.close();
        return entrevista;
    }
    
}
