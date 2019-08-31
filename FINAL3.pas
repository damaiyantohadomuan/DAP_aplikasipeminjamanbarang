{ ====ketentuan program=====
logistik :
- sign up :
  * username/password maka isi kembali
  * jika username terpakai isi kembali
  * batas maximum logistik =3
- login :
  * apabila username/password salah maka login kembali
  * apabila belum terjadi regitrasi maka lakukan menuju halaman registrasi

wewenang :
  * mengisi secara langsung data peminjaman terhadap sistem;



Manager :
- sign up :
 * username/password kosong maka isi kembali
 * batas maximum manager= 1
- login :
 * apabila username/password salah maka login kembali
 * apabila belum terjadi regitrasi maka lakukan menuju halaman registrasi

- wewenang :
 *Dapat check pegawai
 *Dapat check inventory barang
 *Dapat check data peminjaman

Pegawai :
 *Pegawai terdiri dari anggota kelompok memakan Nomor Induk Mahasiswa (NIM);

Peminjaman :
 * Hanya pegawai yang bisa meminjam
 * Kode barang sudah ditentukan , apabila salah maka tidak bisa melanjutkan proses
 * mengenai Tanggal diharapkan menggunakkan format yy/bb/tttt contoh 17/09/2017

Barang :
 * Terdapat 5 barang antara lain :
   -proyektor
    kode_barang  : pro1
    jumlah_barang: 2

   -sound system
    kode_baarang :sou1
    jumlah_barang:5

   -kain hitam
    kode_barang  : kai1
    jumlah_barang: 3

   -Karpet
    kode_barang  : kar1
    jumlah_barang: 0

============================
}

Program peminjaman_barang;
uses crt;


type data_peminjam=record
     nip :string;
     nama_barang:string;
     kode_barang:string;
     tgl_pinjam:string;
     end;

type Barang = record
     Nama_barang : string;
     kode_barang : string;
     jumlah_barang : integer ;
     end;

type Manager = record
     id : string ;
     password :string ;
     end;
Type Logistik = record
     id :string ;
     password :string;
     end;
Type Pegawai = record
     nama : string ;
     nip : string ; //primary
     end;

var
pilih:integer;

Data_peminjaman : packed array [1..50] of data_peminjam;
DataBarang : packed array[1..4] of Barang;
DataManager : Manager;
DataLogistik : packed array [1..3] of Logistik;
DataPegawai : packed array[1..4] of Pegawai;
counter_peminjam,counter_logistik ,x,counter_manager,counter_bayangan: integer;


function CekPegawai(nip:string) : boolean;forward;
function MenuLogin:integer ; forward;
procedure Login() ; forward;
procedure SignUp() ; forward;
procedure peminjaman();forward;
procedure cetak(nip:string;nama_barang:string;kode_barang:string; tgl_pinjam:string);forward;
function CekBarang(kode_barang :string):boolean;forward;
function CekJumlah_barang(kode_barang:string):integer;forward;
procedure AddData_peminjaman (nip:string;nama_barang:string;kode_barang:string; tgl_pinjam:string);forward;
procedure CheckKetersediaanbarang();forward;
procedure CheckDetailPeminjaman();forward;
procedure CheckDataPegawai();forward;
procedure menu_manager;forward;
function kurangi_barang(kode_barang:string):integer;forward;


function kurangi_barang(kode_barang:string):integer ;
var
i:integer;
begin
      i:=1;
      while (i<=4) do
      begin

                if (DataBarang[i].kode_barang=kode_barang) then
                begin
                        kurangi_barang :=DataBarang[i].jumlah_barang;
                        if (DataBarang[i].jumlah_barang>=1) then
                                begin
                                DataBarang[i].jumlah_barang:=DataBarang[i].jumlah_barang-1;
                                end;
                        break;
                end

                else

                begin
                   i:=i+1;
                end;
      end;
      if (i=5) then
      begin
        kurangi_barang :=0;
      end;

end;



procedure menu_manager;
label ulangi;
begin

        clrscr;
        ulangi:
        writeln('1.Check Pegawai ');
        writeln('2.Check Inventory Barang');
        writeln('3.Check peminjaman');
        write('pilih : ' );readln(pilih);
        case (pilih) of
        1: begin
                CheckDataPegawai();
           end;
        2: begin
                CheckKetersediaanBarang();
           end;
        3: begin
                CheckDetailPeminjaman();
           end;
         else
                 writeln('Ikuti instruksi');readln;
                 goto ulangi;
         end;
end;
procedure CheckDataPegawai();
var
x:integer;
label ulangi;
begin
          clrscr;
          x:=1;
          while (x<=4) do
          begin
          writeln('====================');
          writeln(DataPegawai[x].nama);
          writeln(DataPegawai[x].nip);
          x:=x+1;
          end;

          ulangi:
          writeln('====================');
          writeln('1.kembali ke menu');
          writeln('2.logout');
          write('pilih : ');readln(pilih);
          case(pilih)of
          1:begin
                menu_manager;
          end;
          2:begin
                MenuLogin();
          end;
          else
                writeln('Ikuti instruksi');readln;
                 goto ulangi;

          end;


end;

procedure CheckDetailPeminjaman();
var
x:integer;
label ulangi;
begin
          clrscr;
          x:=1;
          while(x<=counter_peminjam) do
          begin
          writeln('====================');
          writeln(Data_peminjaman[x].nip);
          writeln(Data_peminjaman[x].nama_barang);
          writeln(Data_peminjaman[x].kode_barang);
          writeln(Data_peminjaman[x].tgl_pinjam);

          x:=x+1;
          end;

          ulangi:
          writeln('====================');
          writeln('1.kembali ke menu');
          writeln('2.logout');
          writeln('====================');
          write('pilih : ');readln(pilih);
          case(pilih)of
          1:begin
                menu_manager;
          end;
          2:begin
                MenuLogin();
          end;
          else
                writeln('Ikuti instruksi');readln;
                 goto ulangi;

          end;
end;

procedure CheckKetersediaanbarang();
var
x:integer;
label ulangi;
begin
        clrscr;
        x:=1;
        while (x<=4) do
                begin
                writeln('====================');
                writeln (DataBarang[x].Nama_barang);
                writeln (DataBarang[x].kode_barang);
                writeln (DataBarang[x].jumlah_barang);

                x:=x+1;
                end;

          ulangi:
          writeln('====================');
          writeln('1.kembali ke menu');
          writeln('2.logout');
          write('pilih : ');readln(pilih);
          writeln('====================');readln;
          case(pilih)of
          1:begin
                menu_manager;
          end;
          2:begin
                MenuLogin();
          end;
          else
                writeln('Ikuti instruksi');readln;
                 goto ulangi;

          end;

end;



procedure AddData_peminjaman (nip:string;nama_barang:string;kode_barang:string; tgl_pinjam:string);
begin
     Data_peminjaman[counter_peminjam].nip:=nip;
     Data_peminjaman[counter_peminjam].nama_barang:=nama_barang;
     Data_peminjaman[counter_peminjam].kode_barang:=kode_barang;
     Data_peminjaman[counter_peminjam].tgl_pinjam:=tgl_pinjam;
end;

procedure cetak(nip:string;nama_barang:string;kode_barang:string; tgl_pinjam:string);
label ulangimenu;
begin
        clrscr;
        writeln('=================bukti peminjaman=================');
        writeln('Nomor Induk Pegawai  : ',nip);
        writeln('Nama barang pinjaman : ',nama_barang);
        writeln('Kode barang          : ',kode_barang);
        writeln('tgl_pinjam           : ',tgl_pinjam );
        writeln('                       TTD   ');
        writeln('                     LOGISTIK');
        writeln('===================================================');readln;

        AddData_peminjaman(nip,nama_barang,kode_barang,tgl_pinjam);
        counter_peminjam:=counter_peminjam+1;
        writeln('== Menu ==');
        writeln('1. Kembali ingin melakukan peminjaman barang ');
        writeln('2. Logout ');
        write('pilih : ');readln(pilih);
        ulangimenu:
        case(pilih) of
        1: begin
                peminjaman();
           end;
        2: begin
                MenuLogin();
           end;

        else
                writeln('ikuti instruksi');readln;
                goto ulangimenu;
        end;

end;

function CekJumlah_barang (kode_barang:string):integer;
var
i:integer;
begin
      i:=1;
      while (i<=4) do
      begin

                if (DataBarang[i].kode_barang=kode_barang) then
                begin
                        CekJumlah_barang:=DataBarang[i].jumlah_barang;
                        break;
                end

                else

                begin
                   i:=i+1;
                end;
      end;
      if (i=5) then
      begin
        CekJumlah_barang:=0;
      end;

end;


function CekBarang (kode_barang : string ): boolean;
var
i:integer;
begin
      i:=1;
      while (i<=4) do
      begin

                if (DataBarang[i].kode_barang=kode_barang) then
                begin
                        if (DataBarang[i].jumlah_barang<>0)then
                                CekBarang:=true;
                                break;
                end

                else

                begin
                   i:=i+1;
                end;
      end;
      if (i=5) then
      begin
        CekBarang:=false;
      end;

end;



procedure peminjaman() ;
var
nip,nama_barang,kode_barang,tgl_pinjam:string ;
tanda:integer;
label ulangimenu1,ulangimenu2,ulangi,ulangi1,ulangi3;
begin
        ulangi:
        clrscr;
        writeln('======= PENGISIAN  DATA ===========');
        writeln('======== DATA-PEMINJAM ============');


        write  ('Nip                : ');readln(nip);

                if (CekPegawai(nip)=false) then
                begin
                    ulangimenu1:
                    writeln('Nip tidak tersedia');
                    writeln('Ingin coba lagi ?');
                    writeln('1. Iya ');
                    writeln('2. Tidak dan Logout ');
                    write('pilih : ');readln(pilih);
                        if (pilih=1) then
                        begin
                                goto ulangi;
                        end
                        else if(pilih=2) then
                        begin
                                Login();
                        end
                        else
                                writeln('ikuti instruksi');readln;
                                goto ulangimenu1;
                end;

        ulangi1:
        writeln('============DATA BARANG ===========');readln;
        write  ('Nama_barang        : ');readln(nama_barang);
        write  ('Kode_barang        : ');readln(kode_barang);
        writeln (' ');readln;
                if (CekBarang(kode_barang)=false) then
                begin
                    ulangimenu2:
                    writeln('Kode Barang tidak tersedia');
                    writeln('Ingin coba lagi ?');
                    writeln('1. Iya ');
                    writeln('2. Tidak dan Logout ');
                    write('pilih : ');readln(pilih);
                        if (pilih=1) then
                        begin
                                goto ulangi1;
                        end
                        else if (pilih=2) then
                        begin
                                Login();
                        end
                        else
                                writeln('ikuti instruksi ');readln;
                                goto ulangimenu2;

                end;


        writeln('==========MASA PEMINJAMAN==========');readln;
        writeln('FORMAT : dd/mm/yyyyy');
        write  ('Tanggal peminjaman : ');readln(tgl_pinjam);
        writeln('===================================');readln;
        writeln (' ');readln;

        if (CekJumlah_barang(kode_barang)=0) then
                begin
                        ulangi3:
                        writeln('Mohon maaf barang tidak tersedia');readln;
                        writeln('1.kembali ingin meminjam');
                        writeln('2.logout');
                        write('pilih : ');readln(pilih);
                        writeln('====================');readln;
                        case(pilih)of

                                1:begin
                                        goto ulangi;
                                end;
                                2:begin
                                        MenuLogin();
                                end;
                                else
                                writeln('Ikuti instruksi');readln;
                                goto ulangi3;

                        end;
                end;

        if ((nip='') or (nama_barang='') or (kode_barang='')or(tgl_pinjam='')) then
                begin
                        writeln('Data tidak boleh kosong');readln;
                        goto ulangi;
                end
        else
                begin
                        writeln('TERALIHKAN proses CETAK ');readln;
                        kurangi_barang(kode_barang);
                        cetak(nip,nama_barang,kode_barang,tgl_pinjam);
                end;

end;

function CekPegawai (nip : string ): boolean;
var
i:integer;
begin
      i:=1;
      while (i<=4) do
      begin

                if (DataPegawai[i].nip=nip) then
                begin
                   CekPegawai:=true;
                   break;

                end
                else
                begin
                   i:=i+1;
                end;
      end;
      if (i=5) then
      begin
        CekPegawai:=false;
      end;

end;

function MenuLogin:integer ;
label ulangimenu;
begin

 clrscr;
 ulangimenu:
 writeln ('====WELCOME====');
 writeln ('1.Login');
 writeln ('2.Sign up');
 write('pilih : ');
 readln (pilih);
 writeln ('================');

 case (pilih) of
 1: begin
        Login();
    end;
 2: begin
        Signup();

    end;
 else
        writeln('ikuti instruksi');readln;
        goto ulangimenu;
end;
end;


procedure SignUp();
var
username,password : string;
label ulangimenu, ulangi,ulangi1,ulangi2,ulangi3;
begin
clrscr;
    ulangimenu:

    writeln('===Menu SignUp====');
    writeln('1.Sign up logistik');
    writeln('2.Sign up Manager');
    write('pilih : ');
    readln(pilih);
    writeln('===================');
    case (pilih) of
    1:begin
        if (counter_logistik<=3) then
        begin
        ulangi1:
        writeln('Sign up Logistik');
                if (counter_logistik=1) then
                begin
                write('Input username : ');
                readln (username);
                write('input password : ');
                readln(password);
                        if ((username='') or (password='')) then
                        begin
                             writeln('Username/password tidak boleh kosong');readln;
                             goto ulangi1;
                        end;
                DataLogistik[counter_logistik].id:=username;
                DataLogistik[counter_logistik].password:=password;
                counter_logistik:=counter_logistik+1;
                Menulogin();
                end

                else
                begin
                ulangi:
                ulangi2:
                write('Input username : ');
                readln (username);
                counter_bayangan:=counter_logistik;
                        while (counter_bayangan>=1) do
                        begin
                                if (username=DataLogistik[counter_bayangan].id) then
                                begin
                                        write('username sudah terpakai');readln;
                                        goto ulangi;
                                end;
                                counter_bayangan:=counter_bayangan-1;
                        end;
                end;
                write('Input password : ');readln(password);

                        if ((username='') or (password='')) then
                        begin
                             writeln('Username/password tidak boleh kosong');readln;
                             goto ulangi2;
                        end;

                DataLogistik[counter_logistik].id:=username;
                DataLogistik[counter_logistik].password:=password;
                counter_logistik:=counter_logistik+1;
                MenuLogin();
        end
        else
        begin
                writeln('pendaftaran mencapai titik maksimum');
                readln;
                MenuLogin();
        end;
      end;
    2:begin
      if (counter_manager=1) then
        begin
        ulangi3:
        writeln('==Sign up Manager==');
        write('Input username : ');
        readln (username);
        write('input password : ');
        readln(password);
                if ((username='') or (password='')) then
                begin
                        writeln('Username/password tidak boleh kosong');readln;
                        goto ulangi3;
                end;
        DataManager.id:=username;
        DataManager.password:=password;
        counter_manager:=counter_manager+1;
        Menulogin();
        end
      else
        begin
        writeln('pendaftaran mencapai titik maksimum');
        readln;
        MenuLogin();
        end;
      end;
    else
        writeln('Ikuti instruksi');readln;
        goto ulangimenu;
end;
end;



procedure Login();

var
username:string;
password :string;
x:integer;
label ulangimenu,ulangi1,ulangi2,ulangi3;
begin
clrscr;
 ulangimenu:
 x:=1;
 writeln('====Menu Login====');
 writeln('1.Login Logistik');
 writeln('2.Login Manager');
 write('pilih : ');
 readln(pilih);
 writeln('==================');
 case (pilih) of
 2: begin

     if (DataManager.id='null') then
        begin
        writeln('silahkan daftar terlebih dahulu');
        readln;

        SignUp();
        end
     else
        begin
        write('username : ');
        readln(username);
        write('password : ');
        readln(password);
        if ((username<>DataManager.id)or(password<>DataManager.password))then
                begin
                        ulangi3:
                        writeln('Username or password are wrong');
                        writeln('====================');
                        writeln('1.kembali menu login');
                        writeln('2.logout');
                        write('pilih : ');readln(pilih);
                                case(pilih)of
                                1:begin
                                        Login();
                                end;
                                2:begin
                                        MenuLogin();
                                end;
                                else
                                        writeln('Ikuti instruksi');readln;
                                        goto ulangi3;
                                end;
                        readln;

                end
        else if (username=DataManager.id)and(password=DataManager.password)then
                begin
                writeln('Login berhasil');
                readln;
                menu_manager;
                end;
        end;
    end;

 1: begin
     if (DataLogistik[1].id='null') then
     begin
        writeln('silahkan daftar terlebih dahulu');
        readln;
        SignUp();
     end
     else
     begin
     ulangi2:
     write('input username : ');readln(username);
     write('input password : ');readln(password);
        while (x<=counter_logistik) do
        begin
                if (x=4) then
                begin
                        break;
                end;
                if (DataLogistik[x].id=username) and (DataLogistik[x].password=password)then
                begin
                        peminjaman();
                end
                else
                begin
                        x:=x+1;

                end;
        end;

        writeln('username/password are wrong');readln;
        x:=1;
        ulangi1:
        writeln('====================');
        writeln('1.kembali menu login');
        writeln('2.logout');
        write('pilih : ');readln(pilih);
                case(pilih)of
                1:begin
                        Login();
                end;
                2:begin
                        MenuLogin();
                end;
                else
                        writeln('Ikuti instruksi');readln;
                        goto ulangi1;
                end;
                readln;
     end;
    end;

   else
        writeln('ikuti instruksi');readln;
        goto ulangimenu;
end;
end;


{Menu UTAMA}
begin
clrscr;
  DataManager.id:='null';

  for x:=1 to 3 do
  begin
  DataLogistik[x].id:='null';
  end;
  DataBarang[1].Nama_barang:=('proyektor');
  DataBarang[1].kode_barang:=('pro1');
  DataBarang[1].jumlah_barang:=2;
  DataBarang[2].Nama_barang:=('sound system');
  DataBarang[2].kode_barang:=('sou1');
  DataBarang[2].jumlah_barang:=5;
  DataBarang[3].Nama_barang:=('kain hitam');
  DataBarang[3].kode_barang:=('kai1');
  DataBarang[3].jumlah_barang:=3;
  DataBarang[4].Nama_barang:=('Karpet');
  DataBarang[4].kode_barang:=('kar1');
  DataBarang[4].jumlah_barang:=0;


  DataPegawai[1].nama:='Damaiyanto Hadomuan';
  DataPegawai[1].nip:='1301150061';
  DataPegawai[2].nama:='Moch.Febry Nur F';
  DataPegawai[2].nip:='1301154145';
  DataPegawai[3].nama:='Yolanda Modesty';
  DataPegawai[3].nip:='1301154453';
  DataPegawai[4].nama:='Faiq ';
  DataPegawai[4].nip:='1301154187';

  counter_manager:=1;
  counter_logistik:=1;
  counter_peminjam:=1;
  Login();

end.

