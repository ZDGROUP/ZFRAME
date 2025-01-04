package BaseClass;

import java.util.Hashtable;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.naming.*;
import javax.naming.directory.*;
import javax.net.ssl.*;
import zdg.zframe.aspect.log.LIB_ASPECT;
import zdg.zframe.aspect.log.LIB_ASPECT.ViewMode;

public class LDAPSAuthenticator {
   
    public boolean authenticate(String username, String password) {
        // String ldapURL = "ldaps://mydomaincontroller.mydomain.com:636";
        String ldapURL = "ldaps://";
        String baseDN = "";
        //String baseDN = "";
        String searchFilter = "(sAMAccountName=" + username + ")";
        String userDN = "";
        String userPassword = password;
       
        try {
            // Set up the environment for creating the initial context
            Hashtable<String, Object> env = new Hashtable<String, Object>();
            env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
            env.put(Context.PROVIDER_URL, ldapURL);
            env.put(Context.SECURITY_AUTHENTICATION, "simple");
            env.put(Context.SECURITY_PRINCIPAL, username + "@" + baseDN);
            env.put(Context.SECURITY_CREDENTIALS, userPassword);
            
            
            env.put(Context.SECURITY_PROTOCOL, "ssl");
            env.put(Context.DNS_URL, "");
          
            
            
            env.put("java.naming.ldap.factory.socket", "javax.net.ssl.SSLSocketFactory");
            env.put("java.naming.ldap.version", "3");
           
            // Create the initial context
            DirContext ctx = new InitialDirContext(env);
           
            // Search for the user's DN
            SearchControls searchControls = new SearchControls();
            searchControls.setSearchScope(SearchControls.SUBTREE_SCOPE);
            NamingEnumeration<SearchResult> results = ctx.search(baseDN, searchFilter, searchControls);
            if (results.hasMoreElements()) {
                SearchResult result = (SearchResult) results.nextElement();
                userDN = result.getNameInNamespace();
            }
           
            // Bind as the user
            env.put(Context.SECURITY_PRINCIPAL, userDN);
            env.put(Context.SECURITY_CREDENTIALS, userPassword);
            new InitialDirContext(env);
           
            // Authentication succeeded
            return true;
        } catch (AuthenticationException e) {
            // Authentication failed
            //System.out.println(e.getMessage());
            //Logger.getLogger(LDAPSAuthenticator.class.getName()).log(Level.SEVERE, null, e);
            LIB_ASPECT.zPrintD(ViewMode.Error, "LDAP Autentication LEVEL 2 Error "  + e.getMessage(), 1 , e);
            return false;
        } catch (NamingException e) {
            
            
            LIB_ASPECT.zPrintD(ViewMode.Error, "LDAP Autentication LEVEL 1 Error "  + e.getMessage(), 1 , e);
            // Something went wrong
            return false;
        }
    }
   
}
