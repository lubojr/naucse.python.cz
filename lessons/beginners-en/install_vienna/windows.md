# Python installation for Windows 

Go to [the Python website](https://www.python.org/downloads/) and
download the `latest stable version of Python`. At the moment of writing
the materials it is `Python 3.12.3`.

How to know which installer is the right one?
If your computer has 64bit Windows then download *Windows installer (64-bit)*.
If your Windows is only 32bit download *Windows installer (32-bit)*.


> [note]
> If you don't know what Windows version do you have just open **Start**, 
> search **System** and open **System information**.
>
> {{ figure(
    img=static('windows_32v64-bit.png'),
    alt='Windows version',
) }}

Then you can run the installer.
> [warning]  In the beginning check **Install launcher for all Users** and also very important: **Add Python 3.12 to PATH**.


(If you don't have admin rights don't check *Install launcher for all Users*.)

{{ figure(
    img=static('windows_add_python_to_path.png'),
    alt='Python installation',
) }}

Then click **Install now** and follow the instructions.

If you did have your command line open, close it and open again.
