using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;
using Zblah.Utils;

public class GameManager : Singleton<GameManager>
{
    #region Methods
    protected override void Start()
    {
        base.Start();
       // LoadScene("MainMenu");
    }

    public void LoadScene(string sceneName)
    {
        SceneManager.LoadScene(sceneName);
    }
    #endregion Methods
}