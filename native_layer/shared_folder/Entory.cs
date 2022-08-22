using System.Net;
using System.Runtime.InteropServices;

namespace shared_folder;

#pragma warning disable CS8600
public class Entory
{
    static string? networkPath;//@"\\labn\shared";
    static NetworkCredential? credentials; //new NetworkCredential(@"maxnemoy", "нфтфсруьещ");
    static string myNetworkPath = string.Empty;



    [UnmanagedCallersOnly(EntryPoint = "setPath")]
    public static void SetPath(IntPtr pathString)
    {
        string path = Marshal.PtrToStringAnsi(pathString);;
        networkPath = path;
    }

    [UnmanagedCallersOnly(EntryPoint = "setUser")]
    public static void SetCredential(IntPtr userString, IntPtr passwordString)
    {
        string user = Marshal.PtrToStringAnsi(userString);
        string password = "нфтфсруьещ";//Marshal.PtrToStringAnsi(passwordString);
        credentials = new NetworkCredential(user, password);
    }

    [UnmanagedCallersOnly(EntryPoint = "showConfig")]
    public static void ShowConfig()
    {
        Console.WriteLine($"PATH: {networkPath} \nCONFIG: {credentials.UserName}:{credentials.Password}");
    }

    [UnmanagedCallersOnly(EntryPoint = "getFolders")]
    public static IntPtr GetFolders(IntPtr pathString)
    {
        string path = Marshal.PtrToStringAnsi(pathString);

        string folders = "";
        using (new ConnectToSharedFolder(networkPath!, credentials!))
        {
            var dirList = Directory.GetDirectories($"{networkPath}{path}");

            foreach (var item in dirList)
            {
                folders += $"{item}::";
            }
        }
        return Marshal.StringToHGlobalAnsi(folders);
    }

    [UnmanagedCallersOnly(EntryPoint = "numbers")]
    public static int Numbers(int a, int b)
    {
        return a + b;
    }

    [UnmanagedCallersOnly(EntryPoint = "strings")]
    public static IntPtr Strings(IntPtr first, IntPtr second)
    {
        #pragma warning disable CS8600
        string firstString = Marshal.PtrToStringAnsi(first);
        string SecondString = Marshal.PtrToStringAnsi(second);

        string result = $"{firstString} {SecondString}";

        return Marshal.StringToHGlobalAnsi(result);
    }
}
