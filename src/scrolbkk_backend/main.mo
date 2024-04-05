import List "mo:base/List" actor {

  type ProjectStatus = {
    #Starting;
    #Funding;
    #Funded;
    #Failed;
  };

  type Project = {
    project_name : Text;
    project_description : Text;
    wallet_id : Blob;
    current_project_funding : Int;
    project_funding_goal : Int;
    project_start_date : Text;
    project_end_date : Text;
    project_status : ProjectStatus;
  };

  type Wallet = {
    wallet_id : Blob;
    wallet_balance : Int;
  };

  stable var projects : List.List<Project> = List.nil<Project>();
  stable var wallets : List.List<Wallet> = List.nil<Wallet>();

  public query func update_project_status(project_id : Blob, status : ProjectStatus) : async ?Project {
    let project = List.last<Project>(projects);
    switch (project) {
      case (?project) {
        return ?project;
      };
      case (null) {
        return null;
      };
    };
  };

  public query func create_new_project(args : Project) : async Project {
    let list = List.push<Project>(args, projects);
    return args;
  };

  public query func create_wallet_for_project(wallet_id : Blob, project_id : Nat) : async Wallet {
    let wallet = {
      wallet_id = wallet_id;
      wallet_balance = 0;
    };
    let list = List.push<Wallet>(wallet, wallets);
    return wallet;
  };

  public query func get_wallet_by_id(wallet_id : Blob) : async ?Wallet {
    let wallet = List.last<Wallet>(wallets);
    return wallet;
  };

  public query func get_wallet_balance(wallet_id : Blob) : async Int {
    let wallet = List.last<Wallet>(wallets);
    switch (wallet) {
      case (?wallet) {
        return wallet.wallet_balance;
      };
      case (null) {
        return 0;
      };
    };
  };

  public query func get_all_projects() : async List.List<Project> {
    return projects;
  };

  public query func get_project_by_id(project_id : Blob) : async ?Project {
    let project = List.last<Project>(projects);
    return project;
  };

  public query func get_most_recent(project_id : Blob) : async ?Project {
    let project = List.last<Project>(projects);
    return project;
  };

  public query func update_project(args : Project) : async Project {
    let project = List.last<Project>(projects);
    return args;
  };

  public query func fund_project(wallet : Nat, project_id : Blob, amount : Int, args : Project) : async ?Project {
    let project = args;

    if (project.project_status == #Failed) {
      return null;
    };
    if (project.project_status == #Funded) {
      return null;
    };
    if (project.project_status == #Starting) {
      return null;
    };
    if (project.project_status == #Funding) {
      let new_funding = project.current_project_funding + amount;
      if (new_funding >= project.project_funding_goal) {};
      return ?project;
    };
    return null;
  };
};
