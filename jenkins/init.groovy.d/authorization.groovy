import jenkins.model.*;
import com.dabsquared.gitlabjenkins.connection.GitLabConnection
import com.cloudbees.plugins.credentials.*
import com.cloudbees.plugins.credentials.common.*
import com.cloudbees.plugins.credentials.domains.*
import org.jenkinsci.plugins.plaincredentials.impl.*
import com.cloudbees.jenkins.plugins.sshcredentials.impl.*
import hudson.plugins.sshslaves.*
import org.apache.commons.fileupload.*
import org.apache.commons.fileupload.disk.*
import java.nio.file.Files
import com.dabsquared.gitlabjenkins.connection.GitLabApiTokenImpl
import hudson.util.Secret
import jenkins.security.*
import hudson.security.*
import hudson.model.*
import org.apache.commons.lang.*

def instance = Jenkins.getInstance()

def realm = new HudsonPrivateSecurityRealm(false)
realm.createAccount("swarm-slave", RandomStringUtils.randomAlphanumeric(16))
realm.createAccount("jenkins-job-builder", RandomStringUtils.randomAlphanumeric(16))
instance.setSecurityRealm(realm)
instance.save()

def strategy = new GlobalMatrixAuthorizationStrategy()
strategy.add(Jenkins.READ,'authenticated')
strategy.add(Item.BUILD,'authenticated')
strategy.add(Item.READ,'authenticated')
strategy.add(Item.DISCOVER,'authenticated')
strategy.add(Item.CANCEL,'authenticated')
strategy.add(Item.CONFIGURE,'devops-admin')
strategy.add(Item.CONFIGURE,'jenkins-job-builder')
strategy.add(Item.READ,'devops-admin')
strategy.add(Item.READ,'jenkins-job-builder')
strategy.add(Item.READ,'anonymous')
strategy.add(Item.DISCOVER,'jenkins-job-builder')
strategy.add(Item.DISCOVER,'devops-admin')
strategy.add(Item.CREATE,'jenkins-job-builder')
strategy.add(Item.CREATE,'devops-admin')
strategy.add(Item.DELETE,'jenkins-job-builder')
strategy.add(Item.DELETE,'devops-admin')
strategy.add(Jenkins.ADMINISTER, "swarm-slave")
strategy.add(Jenkins.ADMINISTER, "jenkins-job-builder")
strategy.add(Jenkins.ADMINISTER, "devops-admin")
strategy.add(Computer.BUILD,'swarm-slave')
strategy.add(Computer.BUILD,'devops-admin')
strategy.add(Computer.CONFIGURE,'swarm-slave')
strategy.add(Computer.CONFIGURE,'devops-admin')
strategy.add(Computer.CONNECT,'swarm-slave')
strategy.add(Computer.CONNECT,'devops-admin')
strategy.add(Computer.CREATE,'swarm-slave')
strategy.add(Computer.CREATE,'devops-admin')
strategy.add(Computer.DISCONNECT,'swarm-slave')
strategy.add(Computer.DISCONNECT,'devops-admin')
instance.setAuthorizationStrategy(strategy)
instance.save()

//User u = User.get("jenkins-job-builder")  
//ApiTokenProperty t = u.getProperty(ApiTokenProperty.class)
//def token = t.getApiToken()