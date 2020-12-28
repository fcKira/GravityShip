using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ScreenManager : MonoBehaviour
{
    Stack<IScreen> _stack;

    static public ScreenManager instance;

    public Transform mainGameXf; //Variable para indicar cual es el main
    
    private void Awake()
    {
        _stack = new Stack<IScreen>();

        instance = this;
    }

    void Start()
    {
        Push(new ScreenGO(mainGameXf)); //Le asignamos cual va a ser la pantalla base
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.P))
        {
            //Creamos una pantalla en base a un string
            var s = Instantiate(Resources.Load<ScreenPause>("CanvasPause"));
            Push(s);

        }
    }

    public void Pop()
    {
        if (_stack.Count <= 1)
            return;

        _stack.Pop().Free(); //La pantalla sabe como ser libre

        if (_stack.Count > 0)
            _stack.Peek().Activate(); //La pantalla sabe como activarse
    }

    public void Push(IScreen screen)
    {
        if (_stack.Count > 0)
            _stack.Peek().Deactivate(); //La pantalla sabe como desactivarse

        _stack.Push(screen);
        screen.Activate();
    }

    public void Push(string resource)
    {
        var go = Instantiate(Resources.Load<GameObject>(resource));
        Push(go.GetComponent<IScreen>());
    }
}
