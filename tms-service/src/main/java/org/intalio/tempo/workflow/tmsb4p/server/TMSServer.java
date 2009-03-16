package org.intalio.tempo.workflow.tmsb4p.server;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;

import org.apache.axis2.AxisFault;
import org.apache.xmlbeans.XmlObject;
import org.intalio.tempo.workflow.auth.AuthIdentifierSet;
import org.intalio.tempo.workflow.auth.IAuthProvider;
import org.intalio.tempo.workflow.auth.UserRoles;
import org.intalio.tempo.workflow.task.PIPATask;
import org.intalio.tempo.workflow.task.TaskState;
import org.intalio.tempo.workflow.taskb4p.Attachment;
import org.intalio.tempo.workflow.taskb4p.Task;
import org.intalio.tempo.workflow.taskb4p.TaskStatus;
import org.intalio.tempo.workflow.tms.TMSException;
import org.intalio.tempo.workflow.tms.server.permissions.TaskPermissions;
import org.intalio.tempo.workflow.tmsb4p.server.dao.ITaskDAOConnection;
import org.intalio.tempo.workflow.tmsb4p.server.dao.ITaskDAOConnectionFactory;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.w3c.dom.Document;

import com.intalio.wsHT.api.TStatus;

public class TMSServer implements ITMSServer{
    private static final Logger _logger = LoggerFactory.getLogger(TMSServer.class);
    private IAuthProvider _authProvider;
    private ITaskDAOConnectionFactory _taskDAOFactory;
    private TaskPermissions _permissions;
    
    public IAuthProvider getAuthProvider() {
        return _authProvider;
    }

    public void setAuthProvider(IAuthProvider provider) {
        _authProvider = provider;
    }

    public ITaskDAOConnectionFactory getTaskDAOFactory() {
        return _taskDAOFactory;
    }

    public void setTaskDAOFactory(ITaskDAOConnectionFactory factory) {
        _taskDAOFactory = factory;
    }

    public TaskPermissions getPermissions() {
        return _permissions;
    }

    public void setPermissions(TaskPermissions _permissions) {
        this._permissions = _permissions;
    }

    /**************************************
     *  flow-related participant operations
     ***************************************/

    public void create(Task task, String participantToken) throws TMSException {
        System.out.println("tmsserver-> create task");
        try{
            UserRoles ur = _authProvider.authenticate(participantToken);
            System.out.println("userid:"+ur.getUserID());   
        	task.setCreatedBy(ur.getUserID());
        }catch (Exception e ){
            e.printStackTrace();
        }
        
        // TODO check if this user in task initialtor
        ITaskDAOConnection dao = _taskDAOFactory.openConnection();
        try {
        	
            dao.createTask(task);
            dao.commit();
            if (_logger.isDebugEnabled())
                _logger.debug("Workflow Task " + task + " was created");
            // TODO : Use credentials.getUserID() :vb
        } catch (Exception e) {
            _logger.error("Cannot create Workflow Tasks", e); // TODO :
            // TaskIDConflictException
            // must be rethrowed :vb
        } finally {
            dao.close();
        }
        
    }


	public void remove(String participantToken, String taskId)
			throws TMSException {
		// get user
        UserRoles ur = null;
        try{
            ur = _authProvider.authenticate(participantToken);                      
        }catch (Exception e ){
            e.printStackTrace();
            this._logger.error("authenticate user failed",e);
            return;
        }
        
        // do query
        ITaskDAOConnection dao = _taskDAOFactory.openConnection();
        try {
        	dao.deleteTask(taskId);
        } catch (Exception e) {
            _logger.error("remove task failed, task id "+ taskId, e); 
        } finally {
            dao.close();
        }
        
        
        return;
		
	}
	
	public void Release(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void Resume(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void Start(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void Stop(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void claim(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void delegate(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}



	public void forward(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void release(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void resume(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void skip(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void start(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void stop(String participantToken, String identifier) {
		// TODO Auto-generated method stub
		
	}

	public void fail(String participantToken, String identifier,
			String faultName, XmlObject faultData) {
		// TODO Auto-generated method stub
		
	}
	
    /**************************************
     *  data operation operations
     ***************************************/
	
	
	/*****************************************
	 *           administrative operation
	 *****************************************/
	
	
	/*****************************************
	 *           Query operation
	 *****************************************/
	
	
	   public List<Task> query(String participantToken, String selectClause, String whereClause, String orderByClause, int maxTasks, int taskIndexOffset) throws TMSException {
	        // get user
	        UserRoles ur = null;
	        try{
	            ur = _authProvider.authenticate(participantToken);
	           
	            System.out.println("userid:"+ur.getUserID());            
	        }catch (Exception e ){
	            e.printStackTrace();
	            this._logger.error("authenticate user failed",e);
	            return null;
	        }
	        
	        // do query
	        ITaskDAOConnection dao = _taskDAOFactory.openConnection();
	        try {
	                return dao.query(ur, selectClause, whereClause, orderByClause, maxTasks, taskIndexOffset);
	        } catch (Exception e) {
	            _logger.error("Query failed", e); 
	        } finally {
	            dao.close();
	        }
	        
	        
	        return null;
	    }
	   
	   
	   public List<Task> getMyTasks(String participantToken, String taskType, String genericHumanRole, String workQueue, TStatus.Enum[] statusList, String whereClause, String createdOnClause, int maxTasks) throws TMSException{
	        System.out.println("tmsserver->getTasks");
	        UserRoles ur = null;
	        try{
	            ur = _authProvider.authenticate(participantToken);
	            System.out.println("userid:"+ur.getUserID());            
	        }catch (Exception e ){
	            e.printStackTrace();
	            this._logger.error("authenticate user failed",e);
	            return null;
	        }
	        
	        ITaskDAOConnection dao = _taskDAOFactory.openConnection();
	        try {
	            List<TaskStatus> statuses = new ArrayList<TaskStatus>();
	        	for (int i = 0; i< statusList.length;i++){
	        		statuses.add(TaskStatus.valueOf(statusList[i].toString())); 
	        	}
	        	System.out.println("==>call dao.getMyTasks");
	        	List<Task> tasks = dao.getMyTasks(ur, taskType, genericHumanRole, workQueue, statuses, whereClause, createdOnClause, maxTasks);
	           _logger.info("return " + tasks.size()+ " tasks.");
	           
	           return tasks;
	        	
	         //   if (_logger.isDebugEnabled())
	         //       _logger.debug("Workflow Task " + task + " was created");
	            // TODO : Use credentials.getUserID() :vb
	        } catch (Exception e) {
	            _logger.error("Cannot create Workflow Tasks", e); 
	            System.out.println("exception raised,"+e.getMessage());
	            // TODO :
	            // TaskIDConflictException
	            // must be rethrowed :vb
	        } finally {
	            dao.close();
	        }
	        
	        return null;
	    
	    }

	public void complete(String participantToken, String identifier,
			XmlObject xmlObject) {
		// TODO Auto-generated method stub
		
	}
 

}
