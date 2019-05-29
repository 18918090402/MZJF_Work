package canal.client.main;

import canal.client.CanalClientService;

public class CanalClientMain {
	public static void main(String[] args) {
		String instanceName="mysql_dev";
		if(args.length>0){
			instanceName=args[0];
		}
		new CanalClientService(instanceName);
	}
}
