unit UnitIdClient;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, Vcl.StdCtrls, Vcl.ExtCtrls, IdThreadComponent, System.Win.ScktComp;

type
  TFormIdClient = class(TForm)
    IdTCPClient1: TIdTCPClient;
    TitleLabel: TLabel;
    LabelConn: TLabel;
    LedShape: TShape;
    LedSha2: TShape;
    connect_btn: TButton;
    disconnect_btn: TButton;
    Mess2SendLabel: TLabel;
    EditMess: TEdit;
    send_btn: TButton;
    MemoLog: TMemo;
    Label1: TLabel;
    setIPbtn: TButton;
    IdThreadComponent1: TIdThreadComponent;
    procedure connect_btnClick(Sender: TObject);
    procedure IdTCPClient1Connected(Sender: TObject);
    procedure MemoLogChange(Sender: TObject);
    procedure disconnect_btnClick(Sender: TObject);
    procedure IdTCPClient1Disconnected(Sender: TObject);
    procedure send_btnClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure IdThreadComponent1Run(Sender: TIdThreadComponent);
    procedure setIPbtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  FormIdClient: TFormIdClient;

implementation

uses UnitAdd;
{$R *.dfm}




//Create an IdThreadComponent and assign the On Run event to a procedure
procedure TFormIdClient.FormCreate(Sender: TObject);
begin
    // ... create TIdThreadComponent
    //idThreadComponent           := TIdThreadComponent.Create();
    // ... callback functions
    //idThreadComponent.OnRun     := IdThreadComponentRun;
    Caption:='Indy Client - server IP: '+IdTCPClient1.Host;
end;


//call the form to introduze the IP server address and return the IP
//function EnterIPAddress:string;
//begin
//    FormAddress.Visible:=true;
//    repeat Application.ProcessMessages
//    until (FormAddress.Visible=false);
//    EnterIPAddress:=FormAddress.endereco;
//end;

//set the IP Address and the port number
procedure TFormIdClient.setIPbtnClick(Sender: TObject);
begin
    FormAddress.Visible:=true;
    repeat Application.ProcessMessages
    until (FormAddress.Visible=false);
    IdTCPClient1.Host:=FormAddress.endereco;
    IdTCPClient1.Port:=FormAddress.port;
    //connect_btn.Enabled:=true;
    Caption:='Indy Client - server IP: '+IdTCPClient1.Host;
end;

//EVENT connect button On Click
procedure TFormIdClient.connect_btnClick(Sender: TObject);
begin
  //connect_btn.Enabled:=false;  // ... disable connect button
     // ... try to connect to Server
    {if IdTCPClient1.connected then
      try
        IdTCPClient1.IOHandler.Open;
      finally

      end
    else    }
    try
        IdTCPClient1.Connect;
    except
        on E: Exception do begin
            MemoLog.Lines.Add('Connection error: '+E.Message);
            //connect_btn.Enabled := True;
        end;
    end;
    //MemoLog.Lines.Add(IdTCPClient1.Version)
end;




//EVENT executed when disconnect button on click
procedure TFormIdClient.disconnect_btnClick(Sender: TObject);
begin
      //IdTCPClient1.IOHandler.close;
      IdTCPClient1.IOHandler.Writeln('/STOPCLIENT');       //avisa o servidor para desconectar al cliente
      IdTCPClient1.Disconnect;
      //IdTCPClient1Disconnected(Sender)
end;

//final event executed when form is closed
procedure TFormIdClient.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if IdTCPClient1.connected then
      IdTCPClient1.Disconnect
end;



//EVENT executed when IdTCPClient is connected
//Conclusión 1: Si cuando estoy conectado no escribo nada en el servidor NO ME DEJA DESCONECTARME, a no ser
// que esté la estructura while client.connected()
//Conclusion 2: Si en el programa nodemcu está el comando if client.available(), no lee el string
//    porque ese comando sirve cuando el nodemcu es cliente
//Conclusión 3: si no está ese comando, lee el string, pero sólo deja desconectarme si
// desconecto antes que el servidor termine de leer el comando. Solución: agregar en el programa nodemcu
// la estructura while client.connected()
//Conclusion 4: Si el servidor envia um string, el cliente debe leerlo, si no, se puede desconectar, pero
// al volver a conectar da el error client already connected
//Conclusion 5: para salir del loop while client.connected() debe ser ejecutado client.stop(), para eso,
//  antes de desconectar debe enviarse un comando para el servidor también desconectar al cliente
procedure TFormIdClient.IdTCPClient1Connected(Sender: TObject);
begin
     setIPbtn.Enabled:=false;
     connect_btn.Enabled:=false;
     disconnect_btn.Enabled:=true;
     EditMess.Enabled:=true;
     send_btn.Enabled:=true;
     LedShape.Brush.Color:=clRed;
     Label1.Caption:='Client connected to server '+IdTCPClient1.Host;
     MemoLog.Lines.Add('Client connected to server '+IdTCPClient1.Host+' at '+FormatDateTime('hh:nn:ss', Now));
     IdTCPClient1.IOHandler.Writeln('Hello server');
     //IdTCPClient1.IOHandler.Writeln('/LED=OFF');
     //read welcome message
     MemoLog.Lines.Add('Server says: '+IdTCPClient1.IOHandler.ReadLn());
     //MemoLog.Lines.Add('Server also says: '+IdTCPClient1.IOHandler.ReadLn());
     idThreadComponent1.Active:=true;       //active idThreadComponent
end;


//EVENT executed when IdTCPClient is disconnected
procedure TFormIdClient.IdTCPClient1Disconnected(Sender: TObject);
begin
     idThreadComponent1.Active:=false;
     connect_btn.Enabled:=true;
     setIPbtn.Enabled:=true;
     disconnect_btn.Enabled:=false;
     EditMess.Enabled:=false;
     send_btn.Enabled:=false;
     LedShape.Brush.Color:=clMaroon;
     Label1.Caption:='Client disconnected';
     MemoLog.Lines.Add('Client disconnected of server '+IdTCPClient1.Host+' at '+FormatDateTime('hh:nn:ss', Now));
end;



//EVENT executed when MemoLog is on change to scroll the memoLog until the last row
procedure TFormIdClient.MemoLogChange(Sender: TObject);
begin
  SendMessage(MemoLog.Handle, EM_LINESCROLL, 0,MemoLog.Lines.Count);
end;

//EVENT executed when the message written in the edit box is sent
procedure TFormIdClient.send_btnClick(Sender: TObject);
var str2send:string;
begin
  if EditMess.Text<>'' then
    begin
        if EditMess.Text='/STOPCLIENT' then
          disconnect_btnClick(Sender)
        else
          begin
            str2send:=EditMess.Text;
            {if not IdTCPClient1.connected then
              begin
                IdTCPClient1.Connect;
                IdTCPClient1.Socket.WriteLn(str2send);
              end;
            EditMess.Text:='';}
            IdTCPClient1.IOHandler.Writeln(str2send);
          end;
        EditMess.Text:=''
      end
end;




// *****************************************************************************
//   EVENT : onRun()
//           OCCURS WHEN THE CLIENT RECEIVES A MESSAGE FROM THE SERVER
// *****************************************************************************
procedure TFormIdClient.IdThreadComponent1Run(Sender: TIdThreadComponent);
var  msgFromServ : string;
begin
      // ... read message from server
    msgFromServ := IdTCPClient1.IOHandler.ReadLn();
    if msgFromServ<>'' then MemoLog.Lines.Add('Message from server: '+msgFromServ)
end;


end.
