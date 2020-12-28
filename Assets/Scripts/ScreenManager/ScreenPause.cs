using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenPause : MonoBehaviour, IScreen
{
    bool _active;

    public UnityEngine.UI.Text text;

    string _result;

    #region Botones

    public void OnReturn()
    {
        if (!_active) return;

        ScreenManager.instance.Pop();
    }

    public void OnMessage()
    {
        if (!_active) return;

        ScreenManager.instance.Push("CanvasMessage");

    }

    #endregion

    public void Activate()
    {
        _active = true;
    }

    public void Deactivate()
    {
        _active = false;
    }

    public void Free()
    {
        Destroy(gameObject);
    }
}
